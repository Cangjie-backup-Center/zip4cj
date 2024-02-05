package zip4cj.tasks

public open class ExecutorService {
    private var map = ConcurrentHashMap<Int64, Future<Unit>>()
    private let TASK = BlockingQueue<() -> Unit>()
    private let shutdownTASK = BlockingQueue<Int64>()
    private let taskDone = BlockingQueue<Bool>()
    public init() {}

    public static func new(): ExecutorService {
        let service = ExecutorService()
        let threadId = BlockingQueue<Int64>()
        let thread = spawn {
            threadId.enqueue(Thread.currentThread.id)
            while (true) {
                let fn = service.TASK.dequeue()
                fn()
                service.taskDone.enqueue(true)
            }
        }
        service.map.put(threadId.dequeue(), thread)

        spawn {
            while (true) {
                let shutdownId = service.shutdownTASK.dequeue()
                service.map[shutdownId].cancel()
                service.map.remove(shutdownId)
                service.reset()
            }
        }
        return service
    }

    private func reset() {
        let threadId = BlockingQueue<Int64>()
        let thread = spawn {
            threadId.enqueue(Thread.currentThread.id)
            while (true) {
                let fn = this.TASK.dequeue()
                fn()
            }
        }
        this.map.put(threadId.dequeue(), thread)
    }

    public func execute(fn: () -> Unit): Unit {
        this.TASK.enqueue(fn)
        if (this.taskDone.dequeue()) {
            return
        }
    }

    public func shutdown() {
        let id = Thread.currentThread.id
        shutdownTASK.enqueue(id)
    }
}

public class AsyncTaskParameters {
    public let progressMonitor: ProgressMonitor
    public let runInThread: Bool
    public let executorService: ?ExecutorService

    public init(executorService: ?ExecutorService, runInThread: Bool, progressMonitor: ProgressMonitor) {
        this.executorService = executorService
        this.runInThread = runInThread
        this.progressMonitor = progressMonitor
    }
}

public abstract class AsyncZipTask<T> {
    protected let progressMonitor: ProgressMonitor
    protected let runInThread: Bool
    protected let executorService: ?ExecutorService

    public AsyncZipTask(asyncTaskParameters: AsyncTaskParameters) {
        this.progressMonitor = asyncTaskParameters.progressMonitor
        this.runInThread = asyncTaskParameters.runInThread
        this.executorService = asyncTaskParameters.executorService
    }

    public open func execute(taskParameters: T) {
        if (runInThread && ProgressMonitorState.BUSY == (progressMonitor.getState())) {
            throw ZipException("invalid operation - Zip4j is in busy state")
        }

        initProgressMonitor()
        if (runInThread) {
            var totalWorkToBeDone = calculateTotalWork(taskParameters)
            progressMonitor.setTotalWork(totalWorkToBeDone)
            if (let Some(v) <- this.executorService) {
                v.execute(
                    {
                    => try {
                        this.performTaskWithErrorHandling(taskParameters, progressMonitor)
                    } catch (e: ZipException) {
                        throw e
                    } finally {
                        v.shutdown()
                    }
                })
            } else {
                throw NoneValueException("There are no sub threads that can execute tasks.")
            }
        } else {
            performTaskWithErrorHandling(taskParameters, progressMonitor)
        }
    }

    private func performTaskWithErrorHandling(taskParameters: T, progressMonitor: ProgressMonitor) {
        try {
            executeTask(taskParameters, progressMonitor)
            progressMonitor.endProgressMonitor()
        } catch (e: ZipException) {
            progressMonitor.endProgressMonitor(e)
            throw e
        } catch (e: Exception) {
            progressMonitor.endProgressMonitor(e)
            e.printStackTrace()
            throw ZipException(e.message)
        }
    }

    protected func verifyIfTaskIsCancelled() {
        if (!progressMonitor.isCancelAllTasks()) {
            return
        }

        progressMonitor.setResult(ProgressMonitorResult.CANCELLED)
        progressMonitor.setState(ProgressMonitorState.READY)
        throw ZipException("Task cancelled", ZipExceptionType.TASK_CANCELLED_EXCEPTION)
    }

    private func initProgressMonitor() {
        progressMonitor.fullReset()
        progressMonitor.setState(ProgressMonitorState.BUSY)
        progressMonitor.setCurrentTask(getTask())
    }

    protected open func executeTask(taskParameters: T, progressMonitor: ProgressMonitor): Unit

    protected open func calculateTotalWork(taskParameters: T): Int64

    protected open func getTask(): ProgressMonitorTask
}
