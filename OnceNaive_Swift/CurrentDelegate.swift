//
//  CurrentDelegate.swift
//  igola
//
//  Created by LangFZ on 2019/5/24.
//  Copyright © 2019 www.igola.com. All rights reserved.
//

import UIKit

//MARK: - 控制器获取
class CurrentDelegate : NSObject{
    
    class public var window:UIWindow {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).window!
        }
    }
    
    /// Realm数据库
    class public var realmTool:RealmManager {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).realmManager
        }
    }
}

// MARK: - Realm数据库
extension CurrentDelegate {
    
    /// 增
    /// - Parameter model: 保存的模型
    class public func addModel<T>(model: T) {
        realmTool.addModel(model: model)
    }
    
    /// 删除 - 单个模型
    /// - Parameter model: 删除的模型
    class public func deleteModel<T>(model: T) {
        realmTool.deleteModel(model: model)
    }
    /// 删除 - 整张含有这个模型的表
    /// - Parameter model: 删除的模型
    class public func deleteModelList<T>(model: T) {
        realmTool.deleteModelList(model: model)
    }
    
    /// 改   -- 必须主键一致
    /// - Parameter model: 修改的模型
    class public func updateModel<T>(model: T) {
        realmTool.updateModel(model: model)
    }
    
    /// 查   -- model: 查找的模型  -- filter: 是否有筛选条件 例: "name = '大毛'"
    /// - Parameter model: 查找的模型
    /// - Parameter filter: 是否有筛选条件 例: "name = '大毛'"
    class public func queryModel<T>(model: T, filter: String? = nil) -> [T] {
        return realmTool.queryModel(model: model, filter: filter)
    }
}
