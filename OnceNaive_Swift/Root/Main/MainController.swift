//
//  MainController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class MainController: NoneBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        #else
        print("\n\(LocalizationTool.getStr("test.identifier"))")
        #endif
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        if touch.view == self.view {
        
            if LocalizationTool.getCurrentLanguage() == "en" {
                LocalizationTool.saveCurrentLanguage("zh-Hans")
            } else {
                LocalizationTool.saveCurrentLanguage("en")
            }
            
            #if DEBUG
            print("\n\(LocalizationTool.getStr("test.identifier"))")
            #endif
        }
    }
}
