//
//  ZooSummaryRepository.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/14.
//

import Foundation
import Moya

class ZooSummaryRepository {
    
    func fetchAllAnimalInfo(onSuccess: @escaping ([AnimalInfoItem]?) -> (),
                            onFail: @escaping (MoyaError) -> ()) {
        ApiProvider.request(.fetchAllAnimalInfo) {result in
            switch(result) {
            case let .success(response):
                let animalInfoItems:[AnimalInfoItem]? = try? response.map(AllAnimalInfo.self).result.results
                
                animalInfoItems?.forEach({ item in
                    item.aPic01URL = item.aPic01URL.replacingOccurrences(of: "http://", with: "https://")
                    item.aPic02URL = item.aPic02URL.replacingOccurrences(of: "http://", with: "https://")
                    item.aPic03URL = item.aPic03URL.replacingOccurrences(of: "http://", with: "https://")
                    item.aPic04URL = item.aPic04URL.replacingOccurrences(of: "http://", with: "https://")
                })
                
                onSuccess(animalInfoItems)
            case let .failure(error):
                onFail(error)
            }
        }
    }
    
    func fetchAllPlantInfo(onSuccess: @escaping ([PlantInfoItem]?) -> (),
                           onFail: @escaping (MoyaError) -> ()) {
        ApiProvider.request(.fetchAllPlantInfo) {result in
            switch(result) {
            case let .success(response):
                let plantInfoItems:[PlantInfoItem]? = try? response.map(AllPlantInfo.self).result.results
                
                plantInfoItems?.forEach({ item in
                    item.fPic01URL = item.fPic01URL.replacingOccurrences(of: "http://", with: "https://")
                    item.fPic02URL = item.fPic02URL.replacingOccurrences(of: "http://", with: "https://")
                    item.fPic03URL = item.fPic03URL.replacingOccurrences(of: "http://", with: "https://")
                    item.fPic04URL = item.fPic04URL.replacingOccurrences(of: "http://", with: "https://")
                })
                
                onSuccess(plantInfoItems)
            case let .failure(error):
                onFail(error)
            }
        }
    }
}
