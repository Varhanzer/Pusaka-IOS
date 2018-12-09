//
//  Dictionary.swift
//  Pusaka
//
//  Created by Steven Bong on 24/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    func toString() -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options:.prettyPrinted)
            let json = String(data: data, encoding: .utf8)
            return json!
        } catch {
            return ""
        }
    }
    
    func getInt(key: String) -> Int {
        var value = 0
        if let jsonValue = self[key] as? Int {
            value = jsonValue
        } else { print("Failed to get int from json with key: ", key) }
        return value
    }
    
    func getString(key: String) -> String{
        var value = ""
        if let jsonValue = self[key] as? String{
            value = jsonValue
        } else { print("Failed to get dictionary from json with key: ", key) }
        return value
    }
    
    func getDictionary(key: String) -> [String:Any] {
        var dictionary = [String:Any]()
        if let dict = self[key] as? [String:Any] {
            dictionary = dict
        } else { print("Failed to get dictionary from json with key: ", key) }
        return dictionary
    }
    
    func getDictionaryArray(key: String) -> [[String:Any]] {
        var dictionaryArray = [[String:Any]]()
        if let dictArray = self[key] as? [[String:Any]] {
            dictionaryArray = dictArray
        } else { print("Failed to get dictionary array from json with key: ", key) }
        return dictionaryArray
    }
    
    func getBool(key: String) -> Bool {
        var value = false
        if let jsonValue = self[key] as? Bool{
            value = jsonValue
        } else { print("Failed to get double from json with key: ", key) }
        return value
    }
    
    func getDouble(key: String) -> Double {
        var value = 0.0
        if let jsonValue = self[key] as? Double{
            value = jsonValue
        } else { print("Failed to get double from json with key: ", key) }
        return value
    }
    
    func getFloat(key: String) -> Float {
        var value: Float = 0.0
        if let jsonValue = self[key] as? Float{
            value = jsonValue
        } else { print("Failed to get double from json with key: ", key) }
        return value
    }
    
    func getNSArray(key: String) -> NSArray {
        if let nsArray = self[key] as? NSArray {
            return nsArray
        } else {
            return NSArray()
        }
    }
    
}
