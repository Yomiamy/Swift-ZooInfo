//
//  AllZooInfo.swift
//  ZoomInfo
//
//  Created by YomiRY on 2023/11/10.
//

import Foundation

struct AllZooInfo: Codable {
    let result: AllZooInfoResult
}

struct AllZooInfoResult: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [ZooInfo]
}

struct ZooInfo: Codable {
    let id: Int
    let aNameCh: String
    let aNameEn: String
    let aSummary: String
    let aAlsoknown: String
    let aLocation: String
    let aPhylum: String
    let aClass: String
    let aOrder: String
    let aFamily: String
    let aConservation: String
    let aDistribution: String
    let aHabitat: String
    let aFeature: String
    let aBehavior: String
    let aDiet: String
    let aCrisis: String
    let aPic01Alt: String
    let aPic01URL: String
    let aPic02Alt: String
    let aPic02URL: String
    let aPic03Alt: String
    let aPic03URL: String
    let aPic04Alt: String
    let aPic04URL: String
    let aVedioURL: String
    let aUpdate: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case aNameCh = "a_name_ch"
        case aNameEn = "a_name_en"
        case aSummary = "a_summary"
        case aAlsoknown = "a_alsoknown"
        case aLocation = "a_location"
        case aPhylum = "a_phylum"
        case aClass = "a_class"
        case aOrder = "a_order"
        case aFamily = "a_family"
        case aConservation = "a_conservation"
        case aDistribution = "a_distribution"
        case aHabitat = "a_habitat"
        case aFeature = "a_feature"
        case aBehavior = "a_behavior"
        case aDiet = "a_diet"
        case aCrisis = "a_crisis"
        case aPic01Alt = "a_pic01_alt"
        case aPic01URL = "a_pic01_url"
        case aPic02Alt = "a_pic02_alt"
        case aPic02URL = "a_pic02_url"
        case aPic03Alt = "a_pic03_alt"
        case aPic03URL = "a_pic03_url"
        case aPic04Alt = "a_pic04_alt"
        case aPic04URL = "a_pic04_url"
        case aVedioURL = "a_vedio_url"
        case aUpdate = "a_update"
    }
}
