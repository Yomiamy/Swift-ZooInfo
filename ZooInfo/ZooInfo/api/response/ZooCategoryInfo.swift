//
//  ZooCategoryInfo.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/10.
//

struct ZooCategoryInfo: Codable {
    let result: ZooCategoryInfoResult
}

struct ZooCategoryInfoResult: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [ZooCategoryInfoItem]
}

struct ZooCategoryInfoItem: Codable {
    let id: Int
    let eNo: String
    let eCategory: String
    let eName: String
    let ePicURL: String
    let eInfo: String
    let eMemo: String
    let eGeo: String
    let eURL: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case eNo = "e_no"
        case eCategory = "e_category"
        case eName = "e_name"
        case ePicURL = "e_pic_url"
        case eInfo = "e_info"
        case eMemo = "e_memo"
        case eGeo = "e_geo"
        case eURL = "e_url"
    }
    
    func copyWith(
            newId: Int,
            neweNo: String,
            neweCategory: String,
            neweName: String,
            newPicURL: String,
            neweInfo: String,
            neweMemo: String,
            newGeo: String,
            newURL: String
        ) -> ZooCategoryInfoItem {
            return ZooCategoryInfoItem(id: newId
                                       , eNo: neweNo
                                       , eCategory: neweCategory
                                       , eName: neweName
                                       , ePicURL: newPicURL
                                       , eInfo: neweInfo
                                       , eMemo: neweMemo
                                       , eGeo: newGeo
                                       , eURL: newURL)
        }
}