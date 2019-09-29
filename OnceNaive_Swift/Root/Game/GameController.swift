//
//  GameController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import YYModel
import HandyJSON
import Alamofire
import Moya

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
        
        let path = Bundle.main.path(forResource: "TestJSON", ofType: "json")!
        do {
            if let json_data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                
                guard let model = JSONDeserializer<People>.deserializeFrom(json: String.init(data: json_data, encoding: String.Encoding.utf8)) else { return }
                print_debug("\(model.toJSON() ?? [:])")
                
//                guard let model = People.yy_model(withJSON: json_data) else { return }
//                print_debug("\(model.yy_modelToJSONObject() ?? "")")
                
//                let model:People = People().LFZ_objectSetKeyValues(json_data)
//                print_debug("\(model.LFZ_KeyValues())")
                
//                print_debug("name:\(model.name),\nage:\(model.age?.intValue ?? 0),\nman:\(model.man),\nid:\(model.people_id),\ndescription:\(model.people_description)")
            }
        } catch {
            print_debug("解析错误")
        }
    }
}

struct NewPeople: HandyJSON {
    
    public var name:String = ""
    public var age:NSNumber?
    public var man:Bool = false
    public var people_id:String = ""
    public var people_description:String = ""
    
    public var goodFriend:People?
    public var friends:[People] = []
    
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< people_id <-- "id"
        mapper <<< people_description <-- "description"
    }
    
    
    init() {
        
    }
    
}

// MARK: -
@objcMembers
class People: NSObject, NSCoding, HandyJSON {
    
    public var name:String = ""
    public var age:NSNumber?
    public var man:Bool = false
    public var people_id:String = ""
    public var people_description:String = ""
    
    public var goodFriend:People?
    public var friends:[People] = []
    
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
    
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< people_id <-- "id"
        mapper <<< people_description <-- "description"
    }
    
    /** 属性 */
    
    required override init() {
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        self.yy_modelEncode(with: coder)
    }
    required init?(coder: NSCoder) {
        super.init()
        self.yy_modelInit(with: coder)
    }
}




