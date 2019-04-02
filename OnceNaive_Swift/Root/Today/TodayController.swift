//
//  MainController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

private let testCellIdentifier = "testCellIdentifier"

class TodayController: NoneNaviBarController,HadTabBarProtocol,NoneInteractivePopGestureProtocol {
    
    lazy private var today_table: UITableView = {
        
        let today_table = UITableView.init(frame: CGRect.init(x: 0, y: kStatusH, width: kScreenW, height: kScreenH-kStatusH), style: .plain)
        today_table.delegate = self
        today_table.dataSource = self
        today_table.dragDelegate = self
        today_table.dropDelegate = self
        today_table.separatorStyle = .none
        today_table.contentInset = UIEdgeInsets.zero
        today_table.scrollIndicatorInsets = UIEdgeInsets.zero
        
        //
        today_table.register(UITableViewCell.self, forCellReuseIdentifier: testCellIdentifier)
        
        return today_table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
//
//        let push = NoneNaviBarController()
//        push.view.backgroundColor = UIColor.purple
//        self.navigationController?.pushViewController(push, animated: true)
        
        let photoModel = PhotoViewerPhotoModel.init()
        
        let url1 = PhotoViewerPhotoModel()
        url1.photoUrl = URL.init(string: "http://img.netbian.com/file/2019/0312/e70d8c660d7321b25096cb7247f9a11a.jpg")
        photoModel.photoData.append(url1)
        
        let model2 = PhotoViewerPhotoModel()
        model2.photoName = "bizhi2.jpg"
        photoModel.photoData.append(model2)
        
        let model6 = PhotoViewerPhotoModel()
        model6.photoName = "bizhi6.jpg"
        photoModel.photoData.append(model6)
        
        let model10 = PhotoViewerPhotoModel()
        model10.photoName = "bizhi10.jpg"
        photoModel.photoData.append(model10)
        
        let photoVC:PhotoViewerController = PhotoViewerController()
        photoVC.data = photoModel
        photoVC.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(photoVC, animated: true, completion: nil)
    }
}

extension TodayController:UITableViewDelegate,UITableViewDataSource,UITableViewDropDelegate,UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}

