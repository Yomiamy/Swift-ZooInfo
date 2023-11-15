//
//  BaseViewModel.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/16.
//

import Foundation

class BaseViewModel<T> where T:BaseRepository {
    
    var repository:T?
    
    required init() {
        self.repository = T()
    }
    
    func onClear() {
        self.repository?.onClear()
        self.repository = nil
    }
}
