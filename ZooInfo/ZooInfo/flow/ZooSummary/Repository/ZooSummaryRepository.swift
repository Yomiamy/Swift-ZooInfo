//
//  ZooSummaryRepository.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/14.
//

import Foundation
import RxMoya
import Moya
import RxSwift

class ZooSummaryRepository {
    func fetchAllInfo(onSuccess: @escaping (([AnimalInfoItem]?, [PlantInfoItem]?)) -> (),
                      onFail: @escaping (Error) -> ()) {
        let obs1 = ApiProvider.rx.request(.fetchAllAnimalInfo).asObservable()
        let obs2 = ApiProvider.rx.request(.fetchAllPlantInfo).asObservable()
        
        let _ = Observable.zip(obs1, obs2)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response1, response2 in
                let animalInfoItems:[AnimalInfoItem]? = try? response1.map(AllAnimalInfo.self).result.results.map({ item in
                    item.aPic01URL = item.aPic01URL.replacingOccurrences(of: "http://", with: "https://")
                    item.aPic02URL = item.aPic02URL.replacingOccurrences(of: "http://", with: "https://")
                    item.aPic03URL = item.aPic03URL.replacingOccurrences(of: "http://", with: "https://")
                    item.aPic04URL = item.aPic04URL.replacingOccurrences(of: "http://", with: "https://")
                    
                    return item
                })
                
                let plantInfoItems:[PlantInfoItem]? = try? response2.map(AllPlantInfo.self).result.results.map({ item in
                    item.fPic01URL = item.fPic01URL.replacingOccurrences(of: "http://", with: "https://")
                    item.fPic02URL = item.fPic02URL.replacingOccurrences(of: "http://", with: "https://")
                    item.fPic03URL = item.fPic03URL.replacingOccurrences(of: "http://", with: "https://")
                    item.fPic04URL = item.fPic04URL.replacingOccurrences(of: "http://", with: "https://")
                    
                    return item
                })
                
                onSuccess((animalInfoItems, plantInfoItems))
            }, onError: { error in
                onFail(error)
            })
    }
}
