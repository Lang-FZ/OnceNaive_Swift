//
//  BaseNavigationController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/5.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    override var shouldAutorotate : Bool {
        return true
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
/*
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let viewController = self.childViewControllers.last {
            //不需要侧滑返回功能, 以后通通继承自 iGolaNoneBackController
            let iskind = viewController.isKind(of: iGolaNoneBackController.self) ||
                viewController.isKind(of: NewFlightsPayCompleteController.self) ||
                viewController.isKind(of: HotelFinishPayVC.self) ||
                viewController.isKind(of: NoneRightBackHtmlVC.self)
            if iskind { return false }
        }
        return self.childViewControllers.count > 1 ? true : false
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        var isHidden = false
        
        iGolaLog(viewController)
        /// 此处的控制器没有导航条，以后通通继承自iGolaNoneBarController
        let isvc = viewController.isKind(of: iGolaOrderListController.self) ||
            (viewController as? MainTabBarViewController) != nil ||
            viewController.isKind(of: WXBaseViewController.self) ||
            viewController.isKind(of: WXBaseSubViewController.self) ||
            viewController.isKind(of: iGolaNoneBarController.self) ||
            viewController.isKind(of: FlightsMainBaseViewcontroller.self)
        
        if isvc {
            isHidden = true
            navigationController.setNavigationBarHidden(true, animated: animated)
        }else{
            navigationController.setNavigationBarHidden(isHidden, animated: animated)
        }
    }*/
}

