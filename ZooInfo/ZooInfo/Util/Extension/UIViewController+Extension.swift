//
//  UIViewController+Extension.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/25.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "確定", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
