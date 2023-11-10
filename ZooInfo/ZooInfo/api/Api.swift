//
//  Api.swift
//  ZoomInfo
//
//  Created by YomiRY on 2023/11/10.
//

import Moya
import Foundation

let ApiProvider = MoyaProvider<Zoom>()

public enum Zoom {
    case fetchCategoryInfo
    case fetchAllZoomInfo
}

extension Zoom: TargetType {
    public var baseURL: URL {
        URL(string: "https://data.taipei")!
    }
    
    public var path: String {
        switch(self) {
        case .fetchCategoryInfo:
            return "/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a"
        case .fetchAllZoomInfo:
            return "/api/v1/dataset/a3e2b221-75e0-45c1-8f97-75acbd43d613"
        }
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var task: Moya.Task {
        switch(self) {
        case .fetchCategoryInfo:
            return .requestParameters(parameters: ["scope": "resourceAquire"], encoding: URLEncoding.queryString)
        case .fetchAllZoomInfo:
            return .requestParameters(parameters: ["scope": "resourceAquire", "limit":1000], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}

