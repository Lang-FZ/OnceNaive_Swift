//
//  MainController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

private let testCellIdentifier = "testCellIdentifier"

class TodayController: NoneNaviBarController, HadTabBarProtocol, NoneInteractivePopGestureProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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

