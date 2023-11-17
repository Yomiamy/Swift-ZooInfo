//
//  ZooCategoryItemCell.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import UIKit
import Kingfisher

class ZooCategoryItemCell: UITableViewCell {
    
    @IBOutlet weak var ivPic: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbMemo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(picUrl: String,
                name: String,
                info: String,
                memo: String) {
        self.ivPic.contentMode = .scaleAspectFill
        self.ivPic.kf.setImage(with: URL(string: picUrl))
        self.lbName.text = name
        self.lbInfo.text = info
        self.lbMemo.text = memo
    }
    
}
