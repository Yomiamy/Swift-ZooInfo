//
//  ZooAboutVC.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/17.
//

import UIKit
import Kingfisher

class ZooAboutVC: UITableViewController {

    
    @IBOutlet weak var aboutIcon: AnimatedImageView!
    @IBOutlet weak var versionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9777818322, green: 0.992886126, blue: 0.9750451446, alpha: 1)
        
        // 版本號
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = "v\(appVersion)"
        }
        
        // 加載本地gif
        let path = Bundle.main.path(forResource: "animated_launch_icon", ofType: "gif")!
        let url = URL(fileURLWithPath: path)
        aboutIcon.kf.setImage(with: url)
    }

}
