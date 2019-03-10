//
//  MainController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class TodayController: NoneNaviBarController,NoneTabBarProtocol,NoneInteractivePopGestureProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
        let push = NoneNaviBarController()
        push.view.backgroundColor = UIColor.purple
        self.navigationController?.pushViewController(push, animated: true)
    }
}

