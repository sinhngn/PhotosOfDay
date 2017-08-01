//
//  PhotoService.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import Foundation

private enum PhotoAPIUrl: String {
    case PhotoOfDay     = "content/photography/en_US/photo-of-the-day/_jcr_content/.gallery.{0}.json"
    case PhotoOfMonth   = "content/.gallery.{0}.json"
}

class DSPhotoService: DSBaseService {
    
    /**
     ## Get Photos. 
     [api_example](http://www.nationalgeographic.com/content/photography/en_US/photo-of-the-day/_jcr_content/.gallery.2017-05.json)
     ````
     EX:
        let request =  DSRequest<DSGallery>(options: .default)
        request.onSuccess = { res in
        }
        DataService.photoService.photos("2017-05", request: request)
     ````
     - important: You can copy code block
     - returns: A item DSGallery
     - parameter  time : `ex"2017-05"`
     - parameter  request : `DSRequest<DSGallery>`
     */
    func photos(_ time: String, request: DSRequest<DSGallery>) {
        
        let url = PhotoAPIUrl.PhotoOfDay.rawValue.url(macros: [time])
        var rq  = Request(.get, url)
        
        rq.cachePolicy = request.cachedType()
        rq.onSuccess = { result in
        
            if let dict = result as? Dictionary<String, AnyObject> {
                let photoGallery = DSGallery(dict: dict)
                request.onSuccess?(photoGallery)
            } else {
                request.onFailure?(DSErrorModel.errorParse(addrFunc: "\(self).photos"))
            }
        }
        
        rq.onFailure = { error in
            request.onFailure?(error)
        }
        
        httpUtillty.request(rq: rq)
    }
    
    ///.... get photo info
    func photoInfor(_ id: String, request: DSRequest<DSGallery>) {
        
    }
    
    ///.... upload a photo
    func uploadPhoto(_ image: NSData, request: DSRequest<DSGallery>) {
        
    }
    
}
