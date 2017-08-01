//
//  BaseService.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import Foundation

enum DSRequestEnum {
    case `default`
    case network
    case cached
}

class DSRequest <Out>: NSObject {
    
    fileprivate var aOption: DSRequestEnum;
    
    init(options: DSRequestEnum) {
        aOption = options
    }
    
    var onSuccess:((_ result: Out)->())?
    var onFailure:((_ error: DSErrorModel)->())?
    var  onUpdate:((_ result: Out)->())?
    
    func cachedType() -> NSURLRequest.CachePolicy {
        switch aOption {
        case .default:
            return NSURLRequest.CachePolicy.returnCacheDataElseLoad
        case .cached:
            return NSURLRequest.CachePolicy.returnCacheDataDontLoad
        case .network:
            return NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        }
    }
}

class DSBaseService: NSObject {
    
    /// Http request
    let httpUtillty: HttpUtility = HttpUtility();
    
    /// Number of Item in a page
    let sizeDefault = 30;
    
    /// Get data from jsion file.
    class func getDataFromFileJsonLocal(_ jsonName:String) -> NSDictionary{
        
        var jsonResult:NSDictionary?
        let pathJson = Bundle.main.path(forResource: jsonName, ofType: ".json")
        
        if let pathJson = pathJson {
            let data = NSData(contentsOfFile: pathJson)
            do {
                if let data = data {
                    jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? NSDictionary
                    return jsonResult!
                }
            } catch {
                print("Load file json error")
            }
        }
        return jsonResult!
    }
 
}
