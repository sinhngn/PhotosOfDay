//
//  ViewController.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showLoadingView() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0, execute: {
            self.hideLoadingView()
        })
    }
    
    func hideLoadingView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

