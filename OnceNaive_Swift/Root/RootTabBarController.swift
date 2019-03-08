//
//  RootTabBarController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class RootTabBarController: BaseTabBarController {

    //main
    private lazy var mainController: BaseNavigationController = {
        let mainController = BaseNavigationController.init(rootViewController: MainController())
        return mainController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(mainController)
    }
}
