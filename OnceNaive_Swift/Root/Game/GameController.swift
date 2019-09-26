//
//  GameController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import YYModel
import MJExtension

class GameController: NoneNaviBarController,HadTabBarProtocol,NoneInteractivePopGestureProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
    }
}
