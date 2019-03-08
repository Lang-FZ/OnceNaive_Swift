//
//  RootTabBarController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

public let today_index = 0
public let game_index = 1
public let app_index = 2
public let upload_index = 3
public let search_index = 4

class RootTabBarController: BaseTabBarController {
    
    //Today
    private lazy var todayController: BaseNavigationController = {
        let todayController = BaseNavigationController.init(rootViewController: TodayController())
        return todayController
    }()
    //Game
    private lazy var gameController: BaseNavigationController = {
        let gameController = BaseNavigationController.init(rootViewController: GameController())
        return gameController
    }()
    //App
    private lazy var appController: BaseNavigationController = {
        let appController = BaseNavigationController.init(rootViewController: AppController())
        return appController
    }()
    //Upload
    private lazy var uploadController: BaseNavigationController = {
        let uploadController = BaseNavigationController.init(rootViewController: UploadController())
        return uploadController
    }()
    //Search
    private lazy var searchController: BaseNavigationController = {
        let searchController = BaseNavigationController.init(rootViewController: SearchController())
        return searchController
    }()
    
    //TabBar
    private lazy var custom_tabBar: RootTabBar = {
        
        let custom_tabBar = RootTabBar.init(frame: CGRect.zero)
        
        custom_tabBar.selected_item = { [weak self] (index) in
            self?.selectedVC(index)
        }
        
        return custom_tabBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true

        self.addChild(todayController)
        self.addChild(gameController)
        self.addChild(appController)
        self.addChild(uploadController)
        self.addChild(searchController)
        
        self.view.addSubview(custom_tabBar)
        custom_tabBar.selectedItem(today_index)
    }
    
    /// 切换 TabBar 选中
    ///
    /// - Parameter index: 选中哪个VC
    private func selectedVC(_ index:Int) {
        self.selectedIndex = index
    }
}
