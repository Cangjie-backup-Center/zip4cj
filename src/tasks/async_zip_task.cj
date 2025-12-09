/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2025. All rights reserved.
 */
package zip4cj.tasks
import std.sync.AtomicBool

public class ExecutorService {
    var thread = Option<Future<Unit>>.None
    let isShutdown = AtomicBool(false)
    let TASK = BlockingQueue<Option<() -> Unit>>()

    public init() {}
    public static func new(): ExecutorService {
        let service = ExecutorService()
        service.reset()
        return service
    }

    func reset() {
        thread = spawn {
            while (true) {
                if (let Some(fn) <- this.TASK.dequeue()) {
                    fn()
                } else {
                    break
                }
            }
        }
    }

    public func execute(fn: () -> Unit): Unit {
        this.TASK.enqueue(fn)
    }

    public func shutdown(self!: Bool = false) {
        isShutdown.store(true)
        this.TASK.enqueue(None)
        if (self) {
            return
        }
        if (let Some(v) <- this.thread) {
            v.cancel()
            v.get() // Wait for the thread to finish
        }
    }

    public func close () {
        if (isShutdown.load()) {
            return
        }
        this.shutdown()
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
                        v.shutdown(self: true)
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
