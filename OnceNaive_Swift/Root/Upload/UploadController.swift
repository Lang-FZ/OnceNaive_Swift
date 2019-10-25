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

class UploadController: NoneNaviBarController, HadTabBarProtocol, NoneInteractivePopGestureProtocol {
    
    var disposeBag = DisposeBag()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: frameMath(30), y: getNavigationBarHeight()+frameMath(20), width: kScreenW-frameMath(60), height: frameMath(400)))
        imageView.backgroundColor = UIColor.orange
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var cameraBtn: UIButton = {
        let cameraBtn = UIButton.init(type: .custom)
        cameraBtn.frame = CGRect.init(x: frameMath(137.5), y: getNavigationBarHeight()+frameMath(420+10), width: frameMath(100), height: frameMath(35))
        cameraBtn.setTitle("拍照", for: .normal)
        cameraBtn.setTitleColor(UIColor.cyan, for: .normal)
        cameraBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        cameraBtn.titleLabel?.font = UIFont.custom(FontName.PFSC_Regular, size: 15)
        return cameraBtn
    }()
    private lazy var galleryBtn: UIButton = {
        let galleryBtn = UIButton.init(type: .custom)
        galleryBtn.frame = CGRect.init(x: frameMath(137.5), y: getNavigationBarHeight()+frameMath(420+10+55), width: frameMath(100), height: frameMath(35))
        galleryBtn.setTitle("相册", for: .normal)
        galleryBtn.setTitleColor(UIColor.cyan, for: .normal)
        galleryBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        galleryBtn.titleLabel?.font = UIFont.custom(FontName.PFSC_Regular, size: 15)
        return galleryBtn
    }()
    private lazy var cropBtn: UIButton = {
        let cropBtn = UIButton.init(type: .custom)
        cropBtn.frame = CGRect.init(x: frameMath(137.5), y: getNavigationBarHeight()+frameMath(420+10+55+55), width: frameMath(100), height: frameMath(35))
        cropBtn.setTitle("裁切", for: .normal)
        cropBtn.setTitleColor(UIColor.cyan, for: .normal)
        cropBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        cropBtn.titleLabel?.font = UIFont.custom(FontName.PFSC_Regular, size: 15)
        return cropBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(imageView)
        view.addSubview(cameraBtn)
        view.addSubview(galleryBtn)
        view.addSubview(cropBtn)
        
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        cameraBtn.rx.tap
        .flatMapLatest { [weak self] _ in
            return UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .camera
                picker.allowsEditing = false
            }
            .flatMap { $0.rx.didFinishPickingMediaWithInfo }
            .take(1)
        }
        .map { info in
            return info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
        .bind(to: imageView.rx.image)
        .disposed(by: disposeBag)
        
        galleryBtn.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map { info in
                return info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        cropBtn.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: UIImagePickerController {

    /**
     Reactive wrapper for `delegate` message.
     */
    public var didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map({ (a) in
                return try castOrThrow(Dictionary<String, AnyObject>.self, a[1])
            })
    }

    /**
     Reactive wrapper for `delegate` message.
     */
    public var didCancel: Observable<()> {
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
            .map {_ in () }
    }
}

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }

    return returnValue
}



func dismissViewController(_ viewController: UIViewController, animated: Bool) {
    if viewController.isBeingDismissed || viewController.isBeingPresented {
        DispatchQueue.main.async {
            dismissViewController(viewController, animated: animated)
        }

        return
    }

    if viewController.presentingViewController != nil {
        viewController.dismiss(animated: animated, completion: nil)
    }
}

extension Reactive where Base: UIImagePickerController {
    static func createWithParent(_ parent: UIViewController?, animated: Bool = true, configureImagePicker: @escaping (UIImagePickerController) throws -> Void = { x in }) -> Observable<UIImagePickerController> {
        return Observable.create { [weak parent] observer in
            let imagePicker = UIImagePickerController()
            let dismissDisposable = imagePicker.rx
                .didCancel
                .subscribe(onNext: { [weak imagePicker] _ in
                    guard let imagePicker = imagePicker else {
                        return
                    }
                    dismissViewController(imagePicker, animated: animated)
                })
            
            do {
                try configureImagePicker(imagePicker)
            }
            catch let error {
                observer.on(.error(error))
                return Disposables.create()
            }

            guard let parent = parent else {
                observer.on(.completed)
                return Disposables.create()
            }

            parent.present(imagePicker, animated: animated, completion: nil)
            observer.on(.next(imagePicker))
            
            return Disposables.create(dismissDisposable, Disposables.create {
                    dismissViewController(imagePicker, animated: animated)
                })
        }
    }
}

open class RxImagePickerDelegateProxy
    : RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {

    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }

}

