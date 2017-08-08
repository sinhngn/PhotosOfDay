//
//  StoryboardManager.swift
//  Buyer
//
//  Created by NS on 8/28/16.
//  Copyright © 2016 Trong. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case Main = "Main"
    case Home = "Home"
}

extension UIStoryboard {
    
    class func photosViewController() -> PTPhotosViewController {
        let vc = UIStoryboard.name(type: .Main,
                                   indentifier: "PTPhotosViewController") as! PTPhotosViewController
       
        return vc
    }
    
    //MARK: - Overal
    class func name(type: StoryboardName, indentifier: String) -> UIViewController {
        let sb = UIStoryboard.name(type: type);
        return sb.instantiateViewController(withIdentifier: indentifier);
    }
    
    class func name(type: StoryboardName) -> UIStoryboard {
        let name  = type.rawValue;
        return UIStoryboard(name: name, bundle: nil)
    }
}
