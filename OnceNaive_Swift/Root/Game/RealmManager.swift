//
//  RealmManager.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/10/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager: NSObject {
    
    // 线程可能会变，此处使用计算属性可以随时更改realm所处线程
    var realm: Realm {
        return try! Realm()
    }
    
    
    // MARK: - 增
    public func addModel<T>(model: T) {
        
        do {
            try realm.write {
                realm.add(model as! Object)
            }
        } catch {}
    }
    
    // MARK: - 删
    // 删除单个
    public func deleteModel<T>(model: T) {
        
        do {
            try realm.write {
                realm.delete(model as! Object)
            }
        } catch {}
    }
    // 删除整张表
    public func deleteModelList<T>(model: T) {
    
        do {
            try realm.write {
                realm.delete( realm.objects((T.self as! Object.Type).self) )
            }
        } catch {}
    }
    
    // MARK: - 改   -- 必须主键一致
    public func updateModel<T>(model: T) {
        
        do {
            try realm.write {
                realm.add(model as! Object, update: Realm.UpdatePolicy.all)
            }
        } catch {}
    }
    
    // MARK: - 查
    public func queryModel<T>(model: T, filter: String? = nil) -> [T] {
        
        var results:Results<Object>
        
        if filter != nil {
            results = realm.objects((T.self as! Object.Type).self).filter(filter ?? "")
        } else {
            results = realm.objects((T.self as! Object.Type).self)
        }
        
        guard results.count > 0 else { return [] }
        
        var modelArray = [T]()
        for model in results {
            modelArray.append(model as! T)
        }
        
        return modelArray
    }
    
    public func configRealm() {
        
        /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
        let dbVersion : UInt64 = 1
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        print_debug(docPath)
        let dbPath = docPath.appending("/defaultDB.realm")
        
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
            if oldSchemaVersion < dbVersion {
                //数据迁移
                
            }
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 服务器配置成功!")
            }else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
}
