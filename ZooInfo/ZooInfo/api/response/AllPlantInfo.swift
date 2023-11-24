//
//  AllPlantInfo.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/14.
//

import Foundation

class AllPlantInfo: Codable {
    let result: AllPlantInfoResult
}

class AllPlantInfoResult: Codable {
    let limit, offset, count: Int
    let sort: String
    let results: [PlantInfoItem]
}

class PlantInfoItem: Codable {
    let id: Int
    let fNameCh1: String?
    let fNameCh2: String?
    var fNameCh: String {
        // 相容處理
        fNameCh1 != nil ? fNameCh1! : fNameCh2!
    }
    let fSummary: String
    let fKeywords: String
    let fAlsoKnown: String
    let fLocation: String
    let fNameEn: String
    let fFamily: String
    let fGenus: String
    let fBrief: String
    let fFeature: String
    let fFunctionApplication: String
    let fPic01ALT: String
    var fPic01URL: String
    let fPic02ALT: String
    var fPic02URL: String
    let fPic03ALT: String
    var fPic03URL: String
    let fPic04ALT: String
    var fPic04URL: String
    let fPdf01ALT: String
    let fPdf01URL: String
    let fPdf02ALT: String
    let fPdf02URL: String
    let fVoice01ALT: String
    let fVoice01URL: String
    let fVoice02ALT: String
    let fVoice02URL: String
    let fVoice03ALT: String
    let fVoice03URL: String
    let fVedioURL: String
    let fUpdate: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fNameCh1 = "\u{feff}F_Name_Ch"
        case fNameCh2 = "F_Name_Ch"
        case fNameEn = "F_Name_En"
        case fSummary = "F_Summary"
        case fAlsoKnown = "F_AlsoKnown"
        case fLocation = "F_Location"
        case fKeywords = "F_Keywords"
        case fFamily = "F_Family"
        case fGenus = "F_Genus"
        case fBrief = "F_Brief"
        case fFeature = "F_Feature"
        case fFunctionApplication = "F_Function＆Application"
        case fPic01ALT = "F_Pic01_ALT"
        case fPic01URL = "F_Pic01_URL"
        case fPic02ALT = "F_Pic02_ALT"
        case fPic02URL = "F_Pic02_URL"
        case fPic03ALT = "F_Pic03_ALT"
        case fPic03URL = "F_Pic03_URL"
        case fPic04ALT = "F_Pic04_ALT"
        case fPic04URL = "F_Pic04_URL"
        case fPdf01ALT = "F_pdf01_ALT"
        case fPdf01URL = "F_pdf01_URL"
        case fPdf02ALT = "F_pdf02_ALT"
        case fPdf02URL = "F_pdf02_URL"
        case fVoice01ALT = "F_Voice01_ALT"
        case fVoice01URL = "F_Voice01_URL"
        case fVoice02ALT = "F_Voice02_ALT"
        case fVoice02URL = "F_Voice02_URL"
        case fVoice03ALT = "F_Voice03_ALT"
        case fVoice03URL = "F_Voice03_URL"
        case fVedioURL = "F_Vedio_URL"
        case fUpdate = "F_Update"
    }
}

