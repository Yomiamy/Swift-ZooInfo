//
//  ZooCardItemCell.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/21.
//

import UIKit

class ZooCardItemCell: UICollectionViewCell {
    
    @IBOutlet weak var defaultCardImageView: UIImageView!
    @IBOutlet weak var realCardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(isNewOpened:Bool, isNeedOpen:Bool, isPaired:Bool, name:String, picUrl: String) {
        self.defaultCardImageView.isHidden = isNeedOpen || isPaired
        
        self.realCardImageView.isHidden = isPaired
        self.realCardImageView.contentMode = .scaleAspectFill
        self.realCardImageView.kf.setImage(with: URL(string: picUrl))
        
        if(isNewOpened) {
            Utils.speechText(text: name)
        }
    }
}
