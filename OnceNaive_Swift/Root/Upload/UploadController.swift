//
//  UploadController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UploadController: NoneNaviBarController,HadTabBarProtocol,NoneInteractivePopGestureProtocol {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: frameMath(30), y: getNavigationBarHeight()+frameMath(20), width: kScreenW-frameMath(60), height: frameMath(400)))
        return imageView
    }()
    private lazy var cameraBtn: UIButton = {
        let cameraBtn = UIButton.init(type: .custom)
        cameraBtn.frame = CGRect.init(x: frameMath(137.5), y: getNavigationBarHeight()+frameMath(420+10), width: frameMath(100), height: frameMath(35))
        cameraBtn.setTitle("拍照", for: .normal)
        cameraBtn.setTitleColor(UIColor.cyan, for: .normal)
        cameraBtn.titleLabel?.font = UIFont.custom(FontName.PFSC_Regular, size: 15)
        cameraBtn.backgroundColor = UIColor.white
        return cameraBtn
    }()
    private lazy var galleryBtn: UIButton = {
        let galleryBtn = UIButton.init(type: .custom)
        galleryBtn.frame = CGRect.init(x: frameMath(137.5), y: getNavigationBarHeight()+frameMath(420+10+55), width: frameMath(100), height: frameMath(35))
        galleryBtn.setTitle("相册", for: .normal)
        galleryBtn.setTitleColor(UIColor.cyan, for: .normal)
        galleryBtn.titleLabel?.font = UIFont.custom(FontName.PFSC_Regular, size: 15)
        galleryBtn.backgroundColor = UIColor.white
        return galleryBtn
    }()
    private lazy var cropBtn: UIButton = {
        let cropBtn = UIButton.init(type: .custom)
        cropBtn.frame = CGRect.init(x: frameMath(137.5), y: getNavigationBarHeight()+frameMath(420+10+55+55), width: frameMath(100), height: frameMath(35))
        cropBtn.setTitle("裁切", for: .normal)
        cropBtn.setTitleColor(UIColor.cyan, for: .normal)
        cropBtn.titleLabel?.font = UIFont.custom(FontName.PFSC_Regular, size: 15)
        cropBtn.backgroundColor = UIColor.white
        return cropBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        view.addSubview(imageView)
        view.addSubview(cameraBtn)
        view.addSubview(galleryBtn)
        view.addSubview(cropBtn)
        
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
//        cameraBtn.rx.tap
//            .flatMapLatest({ () -> ObservableConvertibleType in
//                return UIImagePickerController.rx
//            })
//            .map({ info in
////                return info[]
//            })
//            .bind(to: imageView.rx.image)
    }
}
