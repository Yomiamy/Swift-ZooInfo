//
//  ZooCategoryViewModel.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import Foundation
import ETBinding

class ZooCategoryViewModel : BaseViewModel<ZooCategoryRepository> {
    
    var zooCategoryItems: LiveData<[ZooCategoryInfoItem]?> = LiveData(data: nil)
    var error: LiveData<String?> = LiveData(data: nil)
    
    func fetchZooCategory() {
        self.repository?.fetchZooCategory { [unowned self] zooCategoryInfoItems in
            self.zooCategoryItems.data = zooCategoryInfoItems
        } onFail: { [unowned self] error in
            self.error.data = error.localizedDescription
        }
    }
}
