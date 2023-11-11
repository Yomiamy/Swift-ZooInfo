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
                var zooCategoryInfoItems:[ZooCategoryInfoItem]? = try? response.map(ZooCategoryInfo.self).result.results
                zooCategoryInfoItems = zooCategoryInfoItems?.map({ item in
                    item.copyWith(newId: item.id, 
                                  neweNo: item.eNo,
                                  neweCategory: item.eCategory,
                                  neweName: item.eName,
                                  newPicURL: item.ePicURL.replacingOccurrences(of: "http", with: "https"),
                                  neweInfo: item.eInfo,
                                  neweMemo: item.eMemo,
                                  newGeo: item.eGeo,
                                  newURL: item.eURL)
                })
                onSuccess(zooCategoryInfoItems)
            case let .failure(error):
                onFail(error)
            }
        }
    }
    
}
