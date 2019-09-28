//
//  GameController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import YYModel
import MJExtension

class GameController: NoneNaviBarController,HadTabBarProtocol,NoneInteractivePopGestureProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
//        let dic : [String : Any] = [
//            "name"  :   "xiaoming",
//            "age"   :   18,
//            "man"   :   true
//        ]
//        let model = People().LFZ_objectSetKeyValues(dic)
//        print_debug("name:\(model.name),\nage:\(model.age?.intValue ?? 0),\nman:\(model.man),\nid:\(model.people_id),\ndescription:\(model.people_description)")
        
//        let path = Bundle.main.path(forResource: "TestJSON", ofType: "json")!
//        do {
//            if let json_data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
//                let model = People().LFZ_objectSetKeyValues(json_data)
//                print_debug("\(model.LFZ_KeyValues())")
//                print_debug("name:\(model.name),\nage:\(model.age?.intValue ?? 0),\nman:\(model.man),\nid:\(model.people_id),\ndescription:\(model.people_description)")
//            }
//        } catch {
//            print_debug("解析错误")
//        }
    }
}

// MARK: -
@objcMembers
class People: NSObject {
    
    public var name:String = ""
    public var age:NSNumber?
    public var man:Bool = false
    public var people_id:String = ""
    public var people_description:String = ""
    
    public var goodFriend:People?
    public var friends:[People] = []
    
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
                "goodFriend"    :   People.self
            ]
        }
    }
    override var propertyToClassInArray: [String : NSObject.Type] {
        get {
            return [
                "friends"        :   People.self
            ]
        }
    }
    
    
    /** 属性 */
    override init() {
        super.init()
    }
}
