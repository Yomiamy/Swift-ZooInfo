//
//  BaseRepository.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/15.
//

import Foundation
import RxSwift

class BaseRepository {
    var disposalBag: DisposeBag?
    
    required init() {
        self.disposalBag = DisposeBag()
    }
    
    func onClear() {
        self.disposalBag = nil
    }
}
