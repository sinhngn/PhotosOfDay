//
//  DSErrorModel.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import UIKit

enum SDErrorCode: Int {
    case unknow             = -1000
    case success            = 200
    case errorLocal         = -1
    case parseErrorLocal    = -2 // This is an error from dictionary too wrong
    case maybeInternet      = -3 // Maybe Internet is losted
}

class DSErrorModel: DSBaseModel {
    
    var message: String {
        return self.dictionary.getString(forKey: "message")
    }
    
    var code: Int {
        return self.dictionary.getInt(forKey: "code") ?? SDErrorCode.unknow.rawValue
    }
    
    var codeEnum: SDErrorCode {
        return SDErrorCode(rawValue: self.code) ?? SDErrorCode.unknow
    }

    
    var ds_description: String {
        return self.dictionary.getString(forKey: "description")
    }
    
    static func errorParse(addrFunc: String? = "") -> DSErrorModel {
        let code: String        = String(SDErrorCode.parseErrorLocal.rawValue)
        let message: String     = "Please, Check response from API"
        let description: String = "Error from \(String(describing: addrFunc)). You should check it."
        let model = DSErrorModel.make(code: code,
                                      message: message,
                                      description: description)
        return model
    }
    
    static func make(code: String, message: String, description: String? = "") -> DSErrorModel {
        
        var strCode = code
        
        if (code == "nil") {
            strCode = SDErrorCode.maybeInternet.rawValue.description
        }
        
        let info = [
            "code"          : strCode,
            "message"       : message,
            "description"   : description
        ]
        
        return DSErrorModel(dict: info as Dictionary<String, AnyObject>);
    }
}
