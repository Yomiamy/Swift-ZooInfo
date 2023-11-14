//
//  ZooCategoryRepository.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import Foundation
import Moya

class ZooCategoryRepository {
    
   func fetchZooCategory(onSuccess: @escaping ([ZooCategoryInfoItem]?) -> (),
                          onFail: @escaping (MoyaError) -> ()) {
        ApiProvider.request(.fetchCategoryInfo) { result in
            switch(result) {
            case let .success(response):
                let zooCategoryInfoItems:[ZooCategoryInfoItem]? = try? response.map(ZooCategoryInfo.self).result.results
                zooCategoryInfoItems?.forEach({ item in
                    item.ePicURL = item.ePicURL.replacingOccurrences(of: "http", with: "https")
                })
                onSuccess(zooCategoryInfoItems)
            case let .failure(error):
                onFail(error)
            }
        }
    }
    
}
