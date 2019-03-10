//
//  RootTabBar.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import SnapKit

class RootTabBar: UIView {
    
    var selected_item:((_ index:Int) -> ())?
    
    // MARK: - 模糊背景
    private lazy var visual: UIVisualEffectView = {

        let visual = UIVisualEffectView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kTabBarH))
        let effect = UIBlurEffect.init(style: .light)
        visual.effect = effect
        visual.alpha = 1

        return visual
    }()
//    //separator
//    private lazy var separator: UIView = {
//        let separator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 0.5))
//        separator.backgroundColor = UIColor.init("#A1A1A1")
//        separator.alpha = 0.5
//        return separator
//    }()
    
    
    // MARK: - Today
    private lazy var today: UIView = {
        let today = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW/5, height: kTabBarH))
        today.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectedToday)))
        today.addSubview(today_icon)
        today.addSubview(today_title)
        return today
    }()
    private lazy var today_icon: UIImageView = {
        let today_icon = UIImageView.init()
        today_icon.image = UIImage.init(named: "TabBar_Today_Gray")
        return today_icon
    }()
    private lazy var today_title: UILabel = {
        let today_title = UILabel.init()
        today_title.textColor = UIColor.init("#A1A1A1")
        today_title.text = LocalizationTool.getStr("root.tab.bar.today")
        today_title.textAlignment = .center
        today_title.font = UIFont.custom(FontName.PFSC_Medium, size: 9)
        return today_title
    }()
    
    // MARK: - Game
    private lazy var game: UIView = {
        let game = UIView.init(frame: CGRect.init(x: kScreenW/5, y: 0, width: kScreenW/5, height: kTabBarH))
        game.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectedGame)))
        game.addSubview(game_icon)
        game.addSubview(game_title)
        return game
    }()
    private lazy var game_icon: UIImageView = {
        let game_icon = UIImageView.init()
        game_icon.image = UIImage.init(named: "TabBar_Game_Gray")
        return game_icon
    }()
    private lazy var game_title: UILabel = {
        let game_title = UILabel.init()
        game_title.textColor = UIColor.init("#A1A1A1")
        game_title.text = LocalizationTool.getStr("root.tab.bar.game")
        game_title.textAlignment = .center
        game_title.font = UIFont.custom(FontName.PFSC_Medium, size: 9)
        return game_title
    }()
    
    // MARK: - App
    private lazy var app: UIView = {
        let app = UIView.init(frame: CGRect.init(x: kScreenW/5*2, y: 0, width: kScreenW/5, height: kTabBarH))
        app.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectedApp)))
        app.addSubview(app_icon)
        app.addSubview(app_title)
        return app
    }()
    private lazy var app_icon: UIImageView = {
        let app_icon = UIImageView.init()
        app_icon.image = UIImage.init(named: "TabBar_App_Gray")
        return app_icon
    }()
    private lazy var app_title: UILabel = {
        let app_title = UILabel.init()
        app_title.textColor = UIColor.init("#A1A1A1")
        app_title.text = LocalizationTool.getStr("root.tab.bar.app")
        app_title.textAlignment = .center
        app_title.font = UIFont.custom(FontName.PFSC_Medium, size: 9)
        return app_title
    }()
    
    // MARK: - Upload
    private lazy var upload: UIView = {
        let upload = UIView.init(frame: CGRect.init(x: kScreenW/5*3, y: 0, width: kScreenW/5, height: kTabBarH))
        upload.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectedUpload)))
        upload.addSubview(upload_icon)
        upload.addSubview(upload_title)
        return upload
    }()
    private lazy var upload_icon: UIImageView = {
        let upload_icon = UIImageView.init()
        upload_icon.image = UIImage.init(named: "TabBar_Update_Gray")
        return upload_icon
    }()
    private lazy var upload_title: UILabel = {
        let upload_title = UILabel.init()
        upload_title.textColor = UIColor.init("#A1A1A1")
        upload_title.text = LocalizationTool.getStr("root.tab.bar.upload")
        upload_title.textAlignment = .center
        upload_title.font = UIFont.custom(FontName.PFSC_Medium, size: 9)
        return upload_title
    }()
    
    // MARK: - Search
    private lazy var search: UIView = {
        let search = UIView.init(frame: CGRect.init(x: kScreenW/5*4, y: 0, width: kScreenW/5, height: kTabBarH))
        search.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectedSearch)))
        search.addSubview(search_icon)
        search.addSubview(search_title)
        return search
    }()
    private lazy var search_icon: UIImageView = {
        let search_icon = UIImageView.init()
        search_icon.image = UIImage.init(named: "TabBar_Search_Gray")
        return search_icon
    }()
    private lazy var search_title: UILabel = {
        let search_title = UILabel.init()
        search_title.textColor = UIColor.init("#A1A1A1")
        search_title.text = LocalizationTool.getStr("root.tab.bar.search")
        search_title.textAlignment = .center
        search_title.font = UIFont.custom(FontName.PFSC_Medium, size: 9)
        return search_title
    }()
    
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kTabBarH))
        
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
        self.isUserInteractionEnabled = true
        self.createRootTabBar()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootTabBar {
    
    private func createRootTabBar() {
        
        self.addSubview(self.visual)
//        self.addSubview(self.separator)
        
        self.addSubview(self.today)
        self.addSubview(self.game)
        self.addSubview(self.app)
        self.addSubview(self.upload)
        self.addSubview(self.search)
        
        self.setup_UI()
    }
    // MARK: - 约束
    private func setup_UI() {
        
        today_icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(today.snp.centerX)
            make.top.equalTo(today.snp.top).offset(frameMath(7))
            make.size.equalTo(CGSize.init(width: frameMath(16.5), height: frameMath(20)))
        }
        today_title.snp.makeConstraints { (make) in
            make.centerX.equalTo(today.snp.centerX)
            make.centerY.equalTo(today.snp.top).offset(frameMath(37.5))
        }
        
        game_icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(game.snp.centerX)
            make.top.equalTo(game.snp.top).offset(frameMath(6.5))
            make.size.equalTo(CGSize.init(width: frameMath(20), height: frameMath(21)))
        }
        game_title.snp.makeConstraints { (make) in
            make.centerX.equalTo(game.snp.centerX)
            make.centerY.equalTo(today_title.snp.centerY)
        }
        
        app_icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(app.snp.centerX)
            make.top.equalTo(app.snp.top).offset(frameMath(7.5))
            make.size.equalTo(CGSize.init(width: frameMath(19.5), height: frameMath(19.5)))
        }
        app_title.snp.makeConstraints { (make) in
            make.centerX.equalTo(app.snp.centerX)
            make.centerY.equalTo(today_title.snp.centerY)
        }
        
        upload_icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(upload.snp.centerX)
            make.top.equalTo(upload.snp.top).offset(frameMath(5))
            make.size.equalTo(CGSize.init(width: frameMath(17.5), height: frameMath(21.5)))
        }
        upload_title.snp.makeConstraints { (make) in
            make.centerX.equalTo(upload.snp.centerX)
            make.centerY.equalTo(today_title.snp.centerY)
        }
        
        search_icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(search.snp.centerX)
            make.top.equalTo(search.snp.top).offset(frameMath(7))
            make.size.equalTo(CGSize.init(width: frameMath(20), height: frameMath(20)))
        }
        search_title.snp.makeConstraints { (make) in
            make.centerX.equalTo(search.snp.centerX)
            make.centerY.equalTo(today_title.snp.centerY)
        }
    }
    
    @objc public func selectedItem(_ index:Int, block_action:Bool = true) {
        if block_action {        
            self.selected_item?(index)
        }
        
        if index != today_index {
            today_icon.image = UIImage.init(named: "TabBar_Today_Gray")
            today_title.textColor = UIColor.init("#A1A1A1")
        }
        if index != game_index {
            game_icon.image = UIImage.init(named: "TabBar_Game_Gray")
            game_title.textColor = UIColor.init("#A1A1A1")
        }
        if index != app_index {
            app_icon.image = UIImage.init(named: "TabBar_App_Gray")
            app_title.textColor = UIColor.init("#A1A1A1")
        }
        if index != upload_index {
            upload_icon.image = UIImage.init(named: "TabBar_Update_Gray")
            upload_title.textColor = UIColor.init("#A1A1A1")
        }
        if index != search_index {
            search_icon.image = UIImage.init(named: "TabBar_Search_Gray")
            search_title.textColor = UIColor.init("#A1A1A1")
        }
        
        switch index {
        case today_index:
            today_icon.image = UIImage.init(named: "TabBar_Today_Blue")
            today_title.textColor = UIColor.init("#007AFE")
        case game_index:
            game_icon.image = UIImage.init(named: "TabBar_Game_Blue")
            game_title.textColor = UIColor.init("#007AFE")
        case app_index:
            app_icon.image = UIImage.init(named: "TabBar_App_Blue")
            app_title.textColor = UIColor.init("#007AFE")
        case upload_index:
            upload_icon.image = UIImage.init(named: "TabBar_Update_Blue")
            upload_title.textColor = UIColor.init("#007AFE")
        case search_index:
            search_icon.image = UIImage.init(named: "TabBar_Search_Blue")
            search_title.textColor = UIColor.init("#007AFE")
        default:
            break
        }
    }
}

extension RootTabBar {
    
    @objc private func selectedToday() {
        selectedItem(today_index)
    }
    @objc private func selectedGame() {
        selectedItem(game_index)
    }
    @objc private func selectedApp() {
        selectedItem(app_index)
    }
    @objc private func selectedUpload() {
        selectedItem(upload_index)
    }
    @objc private func selectedSearch() {
        selectedItem(search_index)
    }
}

class CustomTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

