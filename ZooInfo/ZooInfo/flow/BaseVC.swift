//
//  BaseVC.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/16.
//

import UIKit

class BaseVC<T, R> : UIViewController where T:BaseViewModel<R>, R: BaseRepository {

    var viewMode: T? = T()
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewMode?.onClear()
        self.viewMode = nil
    }
}
