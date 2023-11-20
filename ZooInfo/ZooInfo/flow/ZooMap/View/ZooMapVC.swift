//
//  ZooMapVC.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/18.
//

import UIKit
import WebKit
import SKPhotoBrowser

class ZooMapVC: SKPhotoBrowser {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        self.navigationController?.navigationBar.isHidden = true
        
        var images = [SKPhoto]()
        images.append(contentsOf: [
            
            SKPhoto.photoWithImage(UIImage(named: "zh_tw_zoo_map")!),
            SKPhoto.photoWithImage(UIImage(named: "en_zoo_map")!),
            SKPhoto.photoWithImage(UIImage(named: "jp_zoo_map")!),
            SKPhoto.photoWithImage(UIImage(named: "ind_zoo_map")!),
            SKPhoto.photoWithImage(UIImage(named: "vi_zoo_map")!)
        ])
        
        self.photos = images
        self.initializePageIndex(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.hideControls()
    }
}
