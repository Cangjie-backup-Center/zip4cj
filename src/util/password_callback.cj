/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.util

public interface PasswordCallback {
    func getPassword(): Array<Rune>
}
