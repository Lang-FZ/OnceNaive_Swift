//
//  GameController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import YYModel
//import HandyJSON
//import Alamofire
//import Moya
import RealmSwift


class GameController: NoneNaviBarController,HadTabBarProtocol,NoneInteractivePopGestureProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
//        CurrentDelegate.realmTool.deleteModelList(model: People())
        
//        let result = CurrentDelegate.realmTool.queryModel(model: People())
//
//        for item in result {
//            item.addOriginalData()
//            print_debug("\(item.yy_modelToJSONObject() ?? "")")
//        }
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
//        let dic : [String : Any] = [
//            "name"  :   "xiaoming",
//            "age"   :   18,
//            "man"   :   true
//        ]
//        let model = People().LFZ_objectSetKeyValues(dic)
//        print_debug("name:\(model.name),\nage:\(model.age?.intValue ?? 0),\nman:\(model.man),\nid:\(model.people_id),\ndescription:\(model.people_description)")
        
        let path = Bundle.main.path(forResource: "TestJSON", ofType: "json")!
        do {
            if let json_data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                
//                guard let model = JSONDeserializer<People>.deserializeFrom(json: String.init(data: json_data, encoding: String.Encoding.utf8)) else { return }
//                model.addRealmData()
                
//                let result = CurrentDelegate.realmTool.queryModel(model: People())
                
//                print_debug("\(result.toJSON() as Array)")
                
                guard let model = People.yy_model(withJSON: json_data) else { return }
                model.addRealmData()
                
                if let _ = CurrentDelegate.realmTool.queryModel(model: People(), filter: "people_id = '\(model.people_id)'").first?.people_id {
                    CurrentDelegate.realmTool.updateModel(model: model)
                } else {
                    CurrentDelegate.realmTool.addModel(model: model)
                }
                
                print_debug("\(model.yy_modelToJSONObject() ?? "")")
                
//                let model:People = People().LFZ_objectSetKeyValues(json_data)
//                print_debug("\(model.LFZ_KeyValues())")
                
//                print_debug("name:\(model.name),\nage:\(model.age?.intValue ?? 0),\nman:\(model.man),\nid:\(model.people_id),\ndescription:\(model.people_description)")
            }
        } catch {
            print_debug("解析错误")
        }
    }*/
}

    /*
    override var replacedKeyFromPropertyName: [String : Any] {
        get {
            return [
                "people_id"             :   "id",
                "people_description"    :   "description"
            ]
        }
    }
    override var propertyToClass: [String : NSObject.Type] {
        get {
            return [
                "goodFriend"            :   Self.self
            ]
        }
    }
    override var propertyToClassInArray: [String : NSObject.Type] {
        get {
            return [
                "friends"               :   Self.self
            ]
        }
    }*/
    
//    func mapping(mapper: HelpingMapper) {
//        mapper <<< people_id <-- "id"
//        mapper <<< people_description <-- "description"
//    }


enum TestEnum:String {
    
    case click = "click"
    case network = "network"
    case controller = "controller"
    
    static func getEnum(_ str:String) -> TestEnum {
        
        switch str {
    
        case TestEnum.click.rawValue:
            return .click
        case TestEnum.network.rawValue:
            return .network
        case TestEnum.controller.rawValue:
            return .controller
            
        default:
            return .click
        }
    }
}

@objcMembers
class NewPeople: People {
    
    dynamic var link_friends = LinkingObjects(fromType: People.self, property: "friends_realm")
    dynamic var link_goodFriend = LinkingObjects(fromType: People.self, property: "goodFriend")
}

@objcMembers
class People: BaseRLMObject, YYModel {
    
    dynamic var time:String = "\(Date.timeIntervalBetween1970AndReferenceDate + Date.timeIntervalSinceReferenceDate)"
    
    dynamic var name:String? = nil
    dynamic var age:Int = 0
    dynamic var man:Bool = false
    dynamic var type:String? = nil {
        didSet {
            type_enum = TestEnum.getEnum(type ?? "")
        }
    }
    var type_enum:TestEnum = .click
    
    dynamic var people_id:String = ""
    dynamic var people_description:String = ""
    
    dynamic var goodFriend:NewPeople?
    
    // 数组写两份 一份给 Json转模型 HandyJSON用  一份给 数据库转模型 Realm Object用  Realm类型List不是Array HandyJSON不识别
    var friends:[NewPeople] = []
    var friends_realm = List<NewPeople>()
    
    // 解析使用  realm 不能有new alloc "copy", "mutableCopy" 等关键字前缀字段
    var new_description:String = ""
    dynamic var description_realm:String = ""
    
    
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["people_id" : "id", "people_description" : "description"]
    }
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["friends" : NewPeople.self]
    }
    static func modelPropertyBlacklist() -> [String]? {
        return ["people_id_realm", "people_description_realm", "friends_realm", "description_realm", "type_enum"]
    }
    
    
    override class func primaryKey() -> String? {
        return "time"
    }
    override static func ignoredProperties() -> [String] {
        return ["friends", "new_description", "type_enum"]
    }

    // JSON->Model 适配 Model->数据库
    override func addRealmData() {

        // 数组部分
        for item in self.friends {
            item.addRealmData()
        }
        if self.friends_realm.count > 0 && self.friends.count > 0 {
            friends_realm.removeAll()
        }
        friends_realm.append(objectsIn: self.friends)

        // Object部分
        if goodFriend != nil {
            goodFriend?.addRealmData()
        }

        // 属性命名部分
        description_realm = new_description
    }

    // 数据库->Model 适配 Model->JSON
    override func addOriginalData() {

        // 数组部分
        if self.friends_realm.count > 0 && self.friends.count > 0 {
            friends.removeAll()
        }
        for item in self.friends_realm {
            item.addOriginalData()
            friends.append(item)
        }

        // Object部分 有问题暂时没找到原因
        if goodFriend != nil {
            goodFriend?.addOriginalData()
        }

        // 属性命名部分
        new_description = description_realm
    }
}

/*
@objcMembers
class People: BaseRLMObject, HandyJSON {
    
    dynamic var name:String = ""
    dynamic var age:Int = 0
    dynamic var man:Bool = false
    
    var people_id:String = ""
    dynamic var people_id_realm:String = ""
    var people_description:String = ""
    dynamic var people_description_realm:String = ""
    
    dynamic var goodFriend:NewPeople?
    
    // 数组写两份 一份给 Json转模型 HandyJSON用  一份给 数据库转模型 Realm Object用  Realm类型List不是Array HandyJSON不识别
    var friends:[NewPeople] = []
    var friends_realm = List<NewPeople>()
    
    // 解析使用  realm 不能有new alloc "copy", "mutableCopy" 等关键字前缀字段
    var new_description:String = ""
    dynamic var description_realm:String = ""
    
    
    
    override class func primaryKey() -> String? {
        return "people_id_realm"
    }
    override static func ignoredProperties() -> [String] {
        return ["friends", "new_description", "people_id", "people_description"]
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< people_id <-- "id"
        mapper <<< people_description <-- "description"
    }

    
    override func addRealmData() {
        
        // 数组部分
        for item in self.friends {
            item.addRealmData()
        }
        if self.friends_realm.count > 0 && self.friends.count > 0 {
            friends_realm.removeAll()
        }
        friends_realm.append(objectsIn: self.friends)
        
        // Object部分
        if goodFriend != nil {
            goodFriend?.addRealmData()
        }
        
        // 属性命名部分
        description_realm = new_description
        people_id_realm = people_id
        people_description_realm = people_description
    }
    
    override func addOriginalData() {
        
        // 数组部分
        if self.friends_realm.count > 0 && self.friends.count > 0 {
            friends.removeAll()
        }
        for item in self.friends_realm {
            item.addOriginalData()
            friends.append(item)
        }
        
        // Object部分
        if goodFriend != nil {
            goodFriend?.addOriginalData()
        }
        
        // 属性命名部分
        new_description = description_realm
        people_id = people_id_realm 
        people_description = people_description_realm
    }
}*/

class BaseRLMObject: Object, NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init()
    }
    
    //解析的Array数据添加到realm方法 例如：请求的Array数据需要添加到realm List数据库时调用
     //注意点：realmlist直接.append(objectsIn:)添加swift数组的时候，是可以添加到realmlist中的，原因realmlist数组能够识别swift数组类型，但是反之就不行
    func addRealmData(){ }
   
    //realm List数据传递给正常的Array方法 例如：realm List数据转换成model Array时调用
    //注意点：swift数组直接.append(contentsOf:)添加realmlist的时候，是添加不到正常数组里的，原因正常的swift数组不识别realmlist类型，但是反之就可以
    func addOriginalData(){ }
}
