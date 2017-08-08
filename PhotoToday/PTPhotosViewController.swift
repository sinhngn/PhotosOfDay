//
//  PTPhotosViewController.swift
//  PhotoToday
//
//  Created by NS on 7/29/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import UIKit

class PTPhotosViewController: BaseViewController {

    @IBOutlet weak var collectionvView: UICollectionView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnCalendar: UIButton!

    //public
    var vm: PTPhotosVM = PTPhotosVM()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
    }

    func updateUI() {
        self.title             = vm.galleryTitle
        btnNext.isHidden       = (vm.nextItem().url == "")
        btnPrevious.isHidden   = (vm.previousItem().url == "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        
        if sender == self.btnNext {
            vm.nextItemGetData()
        }
        
        if sender == self.btnPrevious {
            vm.previousItemGetData()
        }
        
        if sender == self.btnCalendar {
            //improve...
        }
    }
}

/// API - Data
extension PTPhotosViewController {
   
    func requestData() {
        vm.needUpdate = {res in
            self.updateUI()
            self.collectionvView.reloadData()
        }
        
        vm.apiPhotosOfDay(date: "2017-07")
    }
}

/// Deleagate and dataSouce
extension PTPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionvView.frame.size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.numberOfPhotos == 0 ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = vm.itemAt(index: indexPath)
        let celltemp = collectionView.dequeueReusableCell(withReuseIdentifier: PTPhotoItemCollectionViewCell.name, for: indexPath)
        
        if let cell = celltemp as? PTPhotoItemCollectionViewCell {
            cell.setupData(title: item.title, urlImage: item.urlImage)
        }
        
        return celltemp
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//CELL
class PTPhotoItemCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate{
    
    static var name: String {
        return String(describing: PTPhotoItemCollectionViewCell.self)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setupData(title: String, urlImage: String){
        let url = URL(string: urlImage)
        
        self.imageView.sd_setImage(with: url)
        self.lblTitle.text = title
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
