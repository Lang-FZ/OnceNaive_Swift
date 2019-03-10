//
//  AppDelegate.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/5.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = RootTabBarController.init()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    //将要进入非活跃状态
    func applicationWillResignActive(_ application: UIApplication) {
    }

    //已经进入后台  该方法有5秒去处理任务以及返回结果，返回后，很快App就会被系统挂起
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        //请求几分钟权限  可以让 App在后台被杀死 可以走 WillTerminate 方法
        UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        
        /*
        //请求后台权限 执行任务
        AppBackgroundTaskTool.init().backgroundTask { [weak self] in
            
        }*/
    }

    //程序将要进入前台，但是还没有处于活跃状态时调用
    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    //已经进入前台并处于活跃状态
    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    //程序被杀死时调用
    func applicationWillTerminate(_ application: UIApplication) {
        print_debug("程序被杀死")
    }
}

