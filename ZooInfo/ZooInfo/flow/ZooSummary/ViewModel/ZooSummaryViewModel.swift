//
//  ZooSummaryViewModel.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/14.
//

import Foundation
import ETBinding

class ZooSummaryViewModel {
    
    var animalInfoItems: LiveData<[AnimalInfoItem]?> = LiveData(data: nil)
    var plantInfoItems: LiveData<[PlantInfoItem]?> = LiveData(data: nil)
    var error: LiveData<(Int, String?)?> = LiveData(data: nil)
    
    private let repository: ZooSummaryRepository = ZooSummaryRepository()
    
    func fetchAllInfo(location: String) {
        repository.fetchAllAnimalInfo { [unowned self] animalInfoItems in
            self.animalInfoItems.data = animalInfoItems?.filter({ animalInfoItem in
                animalInfoItem.aLocation.contains(location)
            })
            
            // TODO: Need to be refactor
            repository.fetchAllPlantInfo { [unowned self] plantInfoItems in
                self.plantInfoItems.data = plantInfoItems?.filter({ plantInfoItem in
                    plantInfoItem.fLocation.contains(location)
                })
            } onFail: { [unowned self] error in
                self.error.data = (error.errorCode, error.errorDescription)
            }
        } onFail: { [unowned self] error in
            self.error.data = (error.errorCode, error.errorDescription)
        }
    }
}
