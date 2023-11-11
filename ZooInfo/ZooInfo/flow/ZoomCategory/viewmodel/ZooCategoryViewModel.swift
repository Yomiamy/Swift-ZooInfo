//
//  ZooCategoryViewModel.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import Foundation
import ETBinding

class ZooCategoryViewModel {
    
    var zooCategoryItems: LiveData<[ZooCategoryInfoItem]?> = LiveData(data: nil)
    var error: LiveData<(Int, String?)?> = LiveData(data: nil)
    
    private let repository: ZooCategoryRepository = ZooCategoryRepository()
    
    func fetchZooCategory() {
        repository.fetchZooCategory { zooCategoryInfoItems in
            self.zooCategoryItems.data = zooCategoryInfoItems
        } onFail: { error in
            self.error.data = (error.errorCode, error.errorDescription)
        }
    }
}
