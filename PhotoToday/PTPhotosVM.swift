//
//  PTPhotosVM.swift
//  PhotoToday
//
//  Created by NS on 8/1/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import UIKit

class PTPhotosVM: PTBaseVM {
    
    //public
    var needUpdate: ((_ b: Bool, _ keyCode: String?, _ msg: String?) -> ())?
    
    var galleryTitle: String {
        return gallery.title
    }
    
    var numberOfPhotos: Int {
        return gallery.items.count
    }
    
    //private
    private var gallery: DSGallery = DSGallery(dict: [:])
    
    public func apiPhotosOfDay(date: String) {
        
        let rq = DSRequest<DSGallery>(options: .default)
        
        rq.onSuccess = {res in
            self.gallery = res
            self.needUpdate?(true, nil, nil)
        }
        
        rq.onFailure = { res in
            
            let error   = "\(res.code)"
            let msg     = "\(res.message)"
            
            self.needUpdate?(true, error, msg)
        }
        
        DataService.photoService.photos(date, request: rq)
    }
    
    //Public Function
    
    func itemAt(index: IndexPath) -> (title: String, urlImage: String) {
        let item = self.gallery.items[safe: index.row]
        
        if (item != nil) {
            return ("fullsize: " + (item!.title), item!.imageURLsize(.s2048))
        }
        
        return ("", "")
    }
    
    //for previous item
    func previousItem() -> (title: String, url: String) {
        return ("", self.gallery.previousEndpoint)
    }
    
    public func previousItemGetData() {
        var url = self.gallery.previousEndpoint.components(separatedBy: ".")
        url.removeLast()
        
        let query: String = url.last ?? ""
        if query != "" {
            apiPhotosOfDay(date: query)
        }
    }
    
    //for next item
    func nextItem() -> (title: String, url: String) {
        return ("", self.gallery.nextEndpoint)
    }
    
    public func nextItemGetData() {
        var url = self.gallery.nextEndpoint.components(separatedBy: ".")
        url.removeLast()
        
        let query: String = url.last ?? ""
        if query != "" {
            apiPhotosOfDay(date: query)
        }
    }
}
