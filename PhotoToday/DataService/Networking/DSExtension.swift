//
//  DSExtention.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import Foundation


extension String {
    
    ///Make url with main domain
    func url() -> String {
        var temp: String = "/"
        
        if self.hasPrefix("/") {
            temp = ""
        }
        
        return DSConfig().domain + temp + self
    }
    
    //make url have  macro ex: {0}, {1}...
    func url(macros: [String] = []) -> String {
        var string = self
        var i = 0
        
        for str in macros {
            
            if string.contains("{\(i)}") {
                string = string.replacingOccurrences(of: "{\(i)}", with: str)
                i += 1
            } else {
                print("**Please Check Your Macro**")
                break
            }
        }
        
        return string.url()
    }
    
    ///Return plantCharacter ex Ắ => A
    func toPlantext() -> String {
        return self.folding(options: String.CompareOptions.diacriticInsensitive,
                                               locale: NSLocale.current)
    }
    
    //Return to plain Text
    func toPlanTextLatinBasic() -> String{
        var newString = self
        
        newString = newString.toPlantext().replacingOccurrences(of: "đ", with: "d")
        newString = newString.toPlantext().replacingOccurrences(of: "Đ", with: "D")
        
        return newString
    }
    
    ///Return to Int, if not Number, return defaultNumber
    func toInt(defaultNumber: Int) -> Int {
        let num = Int(self);
       
        if num != nil {
            return num!;
        } else {
            return defaultNumber;
        }
    }
    
    ///Return to Double, if not Number, return defaultNumber
    func toDouble(defaultNumber: Double) -> Double {
        
        if let num = Double(self){
            return num;
        }
        
        return defaultNumber
    }
    
    /// Get month
    func getMonthNow() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let nameOfMonth = dateFormatter.string(from: now)
        return nameOfMonth
    }
    

}

extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Dictionary {
    
    /// Dictionary get a String from key, return "" if key not exist.
    func getInt(forKey key: Key) -> Int? {
        
        var string: String = ""
        
        if self[key] != nil {
            string = String(describing: self[key]!)
           
            let num = Int(string);
            
            if num != nil {
                return num!
            }
        }
        
        return nil
    }
    
    /// Dictionary get a String from key, return "" if key not exist.
    func getString(forKey key: Key) -> String {
        
        var string: String = ""
        
        if self[key] != nil {
            string = String(describing: self[key]!)
        }
        
        return string
    }
    
    /// Dictionary get a Bool from key, return false if key not exist.
    func getBool(forKey key: Key) -> Bool {
    
        if let boole = self[key] as? Bool  {
            return boole;
        }
        
        return false
    }
    
    /// Dictionary get a Dictionary from key, return [:] if key not exist.
    func getDictionary(forKey key: Key) -> Dictionary {
        
        if let dict = self[key] as? Dictionary  {
            return dict;
        }
        
        return [:]
    }
    
    /// Dictionary get a Array from key, return [] if key not exist.
    func getArray(forKey key: Key) -> [Dictionary] {
        
        if let dict = self[key] as? [Dictionary]  {
            return dict;
        }
        
        return []
    }

}
