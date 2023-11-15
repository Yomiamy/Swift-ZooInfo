//
//  ZooSummaryViewModel.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/14.
//

import Foundation
import ETBinding

class ZooSummaryViewModel : BaseViewModel<ZooSummaryRepository> {
    
    var infoItemsTuple: LiveData<([AnimalInfoItem]?, [PlantInfoItem]?)> = LiveData(data: (nil, nil))
    var error: LiveData<String?> = LiveData(data: nil)
    
    func fetchAllInfo(location: String) {
        self.repository?.fetchAllInfo { [unowned self] animalInfoItems, plantInfoItems in
            let animalInfoItems = animalInfoItems?.filter({ animalInfoItem in
                animalInfoItem.aLocation.contains(location)
            })
            
            let plantInfoItems = plantInfoItems?.filter({ plantInfoItem in
                plantInfoItem.fLocation.contains(location)
            })
            
            self.infoItemsTuple.data = (animalInfoItems, plantInfoItems)
        } onFail: { [unowned self]  error in
            self.error.data = error.localizedDescription
        }
    }
}
