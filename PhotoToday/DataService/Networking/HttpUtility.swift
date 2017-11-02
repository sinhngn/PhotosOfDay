//
//  HttpUtility.swift
//  Buyer
//
//  Created by NS on 8/4/16.
//  Copyright © 2016 Trong. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

/// Request class use to setup input for HttpUtility
struct Request {
    
    var method      : Alamofire.HTTPMethod;
    var url         : String;
    var parameters  : [String : AnyObject]?;
    var cachePolicy : NSURLRequest.CachePolicy = .useProtocolCachePolicy
    
    init(_ _method: Alamofire.HTTPMethod, _ _url: String) {
        method = _method;
        url = _url;
    }
    
    var onSuccess:((_ result: Any)->())?
    var onFailure:((_ error: DSErrorModel)->())?
    var onLoading:((_ byte: Any, _ totalByte: Any)->())?
}

class HttpUtility: NSObject {
    
    static var requestCounting: Int = 0;
    
    public let sharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 40
        
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    /**
     ## A Function execute a request to api.
     
     ````
     let url =  "http://api.example.com"
     let rq  = Request(.get, url)
    
     rq.parameters = [...:...]
   
     rq.onSuccess = { result in
     
     }
     rq.onFailure = { error in
     
     }
     
     httpUtillty.request(rq: rq)
     ````
     - important: You can copy code block
     - returns: 2 handlers `request.onSuccess` and `request.onFailure`
     - parameter rq: The request setup with method Get, Post, Push...
     */
    func request(rq: Request) {
    
        sharedManager.session.configuration.requestCachePolicy = rq.cachePolicy
       
        let request = sharedManager.request(rq.url,
                                             method: rq.method,
                                             parameters: rq.parameters,
                                             encoding: URLEncoding.default)
        
        request.responseJSON { res in
            // Hidden Loading on StatusBar
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch res.result {
            case .success (let json):
                rq.onSuccess?(json)
           
            case .failure(let error):
                let httpCode: String  = "\(String(describing: res.response?.statusCode))"
                let message: String  = error.localizedDescription
                let dsError = DSErrorModel.make(code: httpCode,
                                                message: message,
                                                description: res.response?.debugDescription)
                rq.onFailure?(dsError)
            }
        }
        
        // Show Loading on StatusBar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        HttpUtility.requestCounting += 1;
        
        ////debug
        if DSConfig.isShowLog == true {
            print("------------ API_LOG ----------")
            print("- Request Counting: \(HttpUtility.requestCounting)")
            print("- Request url: \(String(describing: request.request?.url?.absoluteString))")
            print("- Cached: \(rq.cachePolicy)")
            print("- Query: \(String(describing: rq.parameters?.description))")
            print("-------------------------------")
        }
    }
    
    func cancelRequest(url: String) {
        sharedManager.cancelRequests(uri: url, complete: {})
    }
    
}

extension Alamofire.SessionManager {
    
    private func cancelTasksByUrl(tasks: [URLSessionTask], url: String) {
        for task in tasks
        {
            if ((task.currentRequest?.url?.description.contains(url)) != nil &&
                task.currentRequest!.url!.description.contains(url))
            {
                print("Cancel success")
                task.cancel()
            }
        }
    }
    
    func cancelRequests(uri: String, complete: @escaping () -> Void) {
        self.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
              
                print(dataTasks.description)
                print(uploadTasks.description)
                print(downloadTasks.description)
                
                self.cancelTasksByUrl(tasks: dataTasks     as [URLSessionTask], url: uri)
                self.cancelTasksByUrl(tasks: uploadTasks   as [URLSessionTask], url: uri)
                self.cancelTasksByUrl(tasks: downloadTasks as [URLSessionTask], url: uri)
                
                complete()
        }

    }
}

