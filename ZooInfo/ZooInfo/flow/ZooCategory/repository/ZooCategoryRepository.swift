//
//  ZooCategoryRepository.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import Foundation
import Moya
import RxMoya
import RxSwift

class ZooCategoryRepository : BaseRepository {
    
    func fetchZooCategory(onSuccess: @escaping ([ZooCategoryInfoItem]?) -> (),
                          onFail: @escaping (Error) -> ()) {
        let _ = ApiProvider.rx.request(.fetchCategoryInfo)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { response in
                let zooCategoryInfoItems:[ZooCategoryInfoItem]? = try? response.map(ZooCategoryInfo.self).result.results
                zooCategoryInfoItems?.forEach({ item in
                    item.ePicURL = item.ePicURL.replacingOccurrences(of: "http://", with: "https://")
                })
                onSuccess(zooCategoryInfoItems)
            } onFailure: { error in
                onFail(error)
            }.disposed(by: self.disposalBag!)
    }
}
