//
//  ResponseExtensionm.swift
//  smiity
//
//  Created by João Borges on 22/08/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


public extension Response {

    func userView(key: String? = nil) -> AnyObject? {
        if let value = self.result.value as? [String:AnyObject] {
            let json = JSON(value)
            var path = self.path(json)

            if key != nil {
                let extraPath: JSONSubscriptType = key!
                path.append(extraPath)
            }
            if json[path].isExists() {
                return json[path].rawValue
            }
        }
        return nil
    }
    func saveToken() -> String? {
        if let value = self.result.value as? [String:AnyObject] {
            let json = JSON(value)
            let path = self.path(json, key: "sessionToken")

            if let token = json[path].string {
                //here we gona save session token
                //MIPlayerConfig.token = token
                print(token)
                return token
            }
        }
        return nil
    }
    func invalidToken() -> Bool {
        var isInvalidToken = false
        if let value = self.result.value as? [String:AnyObject] {
            if let errors = value["errors"] as? [[String:AnyObject]] {
                for error in errors {
                    if error["message"] as? String == "Invalid token" {
                        isInvalidToken = true
                    }
                }
            } else {
                let json = JSON(value)
                let path = self.path(json, key: "sessionToken")

                if let token = json[path].string {
                    //here we gona save session token
                    //MIPlayerConfig.token = token
                    print(token)
                }
            }
        }
        return isInvalidToken
    }
    func path(json: JSON, key: String = "userView") -> [JSONSubscriptType] {
        let rootName = json["data", "session"].isExists() ? "session" : "login"
        let _path: [JSONSubscriptType] = ["data", rootName, key]
        return _path
    }


    // old mobishout services
    func key(key: String) -> AnyObject? {
        if let value = self.result.value as? [String:AnyObject] {
            return value[key]
        }
        return nil
    }

    func jsonArray(key: String) -> JSON {
        var ret = [[String:AnyObject]]()
        if let value = self.result.value as? [String:AnyObject] {
            if let v = value[key] as? [[String:AnyObject]] {
                ret = v
            }
            if let dict = value[key] as? [String:AnyObject] {
                ret = [dict]
            }
        }
        return JSON(ret)
    }

    func json(key: String) -> JSON {
        if let value = self.result.value as? [String:AnyObject] {
            if let v = value[key] {
                return JSON(v)
            }
        }
        return true
    }
}
