//
//  Api.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/10.
//

import Moya
import Foundation

let ApiProvider = MoyaProvider<Zoo>()

public enum Zoo {
    case fetchCategoryInfo
    case fetchAllAnimalInfo
    case fetchAllPlantInfo
}

extension Zoo: TargetType {
    public var baseURL: URL {
        URL(string: "https://data.taipei")!
    }
    
    public var path: String {
        switch(self) {
        case .fetchCategoryInfo:
            return "/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a"
        case .fetchAllAnimalInfo:
            return "/api/v1/dataset/a3e2b221-75e0-45c1-8f97-75acbd43d613"
        case .fetchAllPlantInfo:
            return "/api/v1/dataset/f18de02f-b6c9-47c0-8cda-50efad621c14"
        }
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var task: Moya.Task {
        switch(self) {
        case .fetchCategoryInfo:
            return .requestParameters(parameters: ["scope": "resourceAquire"], encoding: URLEncoding.queryString)
        case .fetchAllAnimalInfo:
            return .requestParameters(parameters: ["scope": "resourceAquire", "limit":1000], encoding: URLEncoding.queryString)
        case .fetchAllPlantInfo:
            return .requestParameters(parameters: ["scope": "resourceAquire", "limit":1000], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}

