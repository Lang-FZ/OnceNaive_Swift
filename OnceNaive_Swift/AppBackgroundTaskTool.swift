//
//  AppBackgroundTaskTool.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class AppBackgroundTaskTool: NSObject {

    private var backgroundTaskID:UIBackgroundTaskIdentifier?
    
    public func backgroundTask(_ task: @escaping () -> Void) {
        
        DispatchQueue.global().async {
            
            //调用这个方法可以让你的应用程序增多30秒的时间来完成一项任务。
            self.backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: background_task_name) { [weak self] in
                //程序在10分钟内未被系统关闭或者强制关闭，则程序会调用此代码块，可以在这里做一些保存或者清理工作
                
                //后台权限任务关闭
                UIApplication.shared.endBackgroundTask(self?.backgroundTaskID ?? UIBackgroundTaskIdentifier.invalid)
                self?.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
            }
            
            //执行任务
            task()
            
            //结束任务
            UIApplication.shared.endBackgroundTask(self.backgroundTaskID ?? UIBackgroundTaskIdentifier.invalid)
            self.backgroundTaskID = UIBackgroundTaskIdentifier.invalid
            
            /*
             如果时间还不够，请使用NSProcessInfo中的performExpiringActivityWithReason:usingBlock:方法（异步执行指定的块并在进程即将被挂起时通知你）来代替
             */
        }
    }
}
