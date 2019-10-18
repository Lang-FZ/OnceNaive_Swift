//
//  SearchController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class SearchController: NoneNaviBarController,HadTabBarProtocol,NoneInteractivePopGestureProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        print_debug("SearchController viewDidLoad")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print_debug("SearchController viewDidAppear")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print_debug("SearchController viewWillAppear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print_debug("SearchController viewDidDisappear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print_debug("SearchController viewWillDisappear")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)

        let vc = TestSecondVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class TestSecondVC: BaseViewController {
    
    // MARK: - 懒加载
    
    
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        print_debug("TestSecondVC viewDidLoad")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print_debug("TestSecondVC viewDidAppear")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print_debug("TestSecondVC viewWillAppear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print_debug("TestSecondVC viewDidDisappear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print_debug("TestSecondVC viewWillDisappear")
    }
}
