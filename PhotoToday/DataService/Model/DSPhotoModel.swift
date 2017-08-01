//
//  DSPhotoModel.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import UIKit

enum PhotoSizeEnum: String{
    case s240   = "240"
    case s320   = "320"
    case s500   = "500"
    case s640   = "640"
    case s800   = "800"
    case s1024  = "1024"
    case s1600  = "1600"
    case s2048  = "2048"
}

class DSGallery: DSBaseModel {
    
    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
        self.items = self.parse_item(dicts: dict.getArray(forKey: "items"))
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///galleryTitle: "Photo of the Day",
    var title: String {
        let result = self.dictionary.getString(forKey: "galleryTitle")
        return result;
    }
    
    ///previousEndpoint: "/content/photography/en_US/photo-of-the-day/_jcr_content/.gallery.2017-04.json"
    var previousEndpoint: String {
        let result = self.dictionary.getString(forKey: "previousEndpoint")
        return result;
    }
    
    /// nextEndpoint: "/content/photography/en_US/photo-of-the-day/_jcr_content/.gallery.2017-06.json",
    var nextEndpoint: String {
        let result = self.dictionary.getString(forKey: "nextEndpoint")
        return result;
    }
    
    var items: [DSPhotoModel] = []
    
    func parse_item(dicts: [Dictionary<String, AnyObject>]) -> [DSPhotoModel] {
        
        var output: [DSPhotoModel] = []
        
        for item in dicts {
            let photo = DSPhotoModel(dict: item)
            output.append(photo)
        }
        
        self.dictionary["item"] = nil
        
        return output
    }
}

class DSPhotoModel: DSBaseModel {

    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///title: "The Blues",
    var title: String {
        let result = self.dictionary.getString(forKey: "title")
        return result;
    }
    
    ///html caption: "<p>The city of Chefchaouen, in northwest Morocco..</p>"
    var caption: String {
        let result = self.dictionary.getString(forKey: "caption")
        return result;
    }
    
    ///credit: "ioannis stamatogiannis"
    var credit: String {
        let result = self.dictionary.getString(forKey: "credit")
        return result;
    }
    
    ///credit: "http://yourshot.nationalgeographic.com/profile/705715/"
    var profileUrl: String {
        let result = self.dictionary.getString(forKey: "profileUrl")
        return result;
    }
    
    ///credit: "Picture of a man walking down a blue alley in Morocco"
    var altText: String {
        let result = self.dictionary.getString(forKey: "altText")
        return result;
    }
    
    ///full_path_url: "http://yourshot.nationalgeographic.com/photos/10230058/"
    var full_path_url: String {
        let result = self.dictionary.getString(forKey: "full_path_url")
        return result;
    }
    
    ///url: "http://yourshot.nationalgeographic.com"
    var url: String {
        let result = self.dictionary.getString(forKey: "url")
        return result;
    }
    
    ///originalUrl: "/u/fQYSUbVfts-djfyeU....."
    var originalUrl: String {
        let result = self.dictionary.getString(forKey: "originalUrl")
        return result;
    }
    
    ///originalUrl: "/u/fQYSUbVfts-djfyeU....."
    var aspectRatio: String {
        let result = self.dictionary.getString(forKey: "aspectRatio")
        return result;
    }
    
    /// full image links
    func imageURLsize(_ photoSize: PhotoSizeEnum) -> String {
        let result = self.url + self.size(photoSize)
        return result;
    }
    
    ///size: "/u/fQYSUbVfts-djfyeU....."
    private func size(_ photoSize: PhotoSizeEnum) -> String {
        let result = self.dictionary.getDictionary(forKey: "sizes")
        let output = result.getString(forKey: photoSize.rawValue)
        return output;
    }
    
    ///internal: false
    var internal_key: Bool {
        let result = self.dictionary.getBool(forKey: "internal")
        return result;
    }
    
    ///pageUrl: "http://...photography/photo-of-the-day/2017/05/fish-auction-india-aerial",
    var pageUrl: String {
        let result = self.dictionary.getString(forKey: "pageUrl")
        return result;
    }
    
    ///publishDate: "May 31, 2017",
    var publishDate: String {
        let result = self.dictionary.getString(forKey: "publishDate")
        return result;
    }
    
    ///yourShot: true,
    var yourShot: Bool {
        let result = self.dictionary.getBool(forKey: "yourShot")
        return result;
    }
    
    ///A Model
    var social: DSSocialModel {
        let dict = self.dictionary.getDictionary(forKey: "social")
        let result: DSSocialModel = DSSocialModel(dict: dict);
        return result
    }
    
    ///A model
    var livefyre: DSLivefyreModel {
        let dict = self.dictionary.getDictionary(forKey: "livefyre")
        let result: DSLivefyreModel = DSLivefyreModel(dict: dict);
        return result
    }
    
    func forChange()  {
        
    }
}

class DSSocialModel: DSBaseModel {
    
    ///og:title: "Fish Market India Image |Â National Geographic Your Shot Photo of the Day",
    var og_title: String {
        let result = self.dictionary.getString(forKey: "og:title")
        return result;
    }
    
    ///og:description: "Boat managers sort th.ional Geographic Your Shot Photo of the Day."
    var og_description: String {
        let result = self.dictionary.getString(forKey: "og:description")
        return result;
    }
    
    ///twitter:site: "@NatGeo"
    var twitter_site: String {
        let result = self.dictionary.getString(forKey: "twitter:site")
        return result;
    }
}

class DSLivefyreModel: DSBaseModel {
    
    ///pageGuid: "153f29b2-4b7f-4f21-b86c-1c79033ccdfc"
    var pageGuid: String {
        let result = self.dictionary.getString(forKey: "pageGuid")
        return result;
    }
    
    ///checksum: "af4b8b7c8ca1deb96a8643c3d001d383",
    var og_description: String {
        let result = self.dictionary.getString(forKey: "og:description")
        return result;
    }
    
    ///lfMetadata: "eyJjdHkiOiJ0ZXh0XC9wbGFpbiI..."
    var lfMetadata: String {
        let result = self.dictionary.getString(forKey: "lfMetadata")
        return result;
    }
    
    ///siteSecret: "uECgsZwy6uIebHYmL2xizrcrvbY="
    var siteSecret: String {
        let result = self.dictionary.getString(forKey: "siteSecret")
        return result;
    }
    
    ///lfSiteId: "318027",
    var lfSiteId: String {
        let result = self.dictionary.getString(forKey: "lfSiteId")
        return result;
    }
    
    ///lfNetworkName: "natgeo.fyre.co",
    var lfNetworkName: String {
        let result = self.dictionary.getString(forKey: "lfNetworkName")
        return result;
    }
    
    ///lfElement: "livefyre-comments"
    var lfElement: String {
        let result = self.dictionary.getString(forKey: "lfElement")
        return result;
    }
    
}

