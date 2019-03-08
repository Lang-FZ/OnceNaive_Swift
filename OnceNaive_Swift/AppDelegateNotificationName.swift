//
//  AppDelegateNotificationName.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

/// 将要进入非活跃状态
public let will_resign_active:NSNotification.Name = UIApplication.willResignActiveNotification
/// 已经进入后台
public let did_enter_background:NSNotification.Name = UIApplication.didEnterBackgroundNotification
/// 程序将要进入前台，但是还没有处于活跃状态时调用
public let will_enter_foreground:NSNotification.Name = UIApplication.willEnterForegroundNotification
/// 已经进入前台并处于活跃状态
public let did_become_active:NSNotification.Name = UIApplication.didBecomeActiveNotification
/// 程序被杀死时调用
public let will_terminate:NSNotification.Name = UIApplication.willTerminateNotification

/// 请求后台权限任务 name
public let background_task_name:String = "beginBackgroundTaskName"
