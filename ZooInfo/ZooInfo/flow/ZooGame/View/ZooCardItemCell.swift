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

    func update(isSelected:Bool, picUrl: String) {
        self.defaultCardImageView.isHidden = isSelected
        
        self.realCardImageView.contentMode = .scaleAspectFill
        self.realCardImageView.kf.setImage(with: URL(string: picUrl))
    }
}
