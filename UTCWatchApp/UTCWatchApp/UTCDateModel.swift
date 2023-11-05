//
//  UTCITmeModel.swift
//  UTCWatchApp
//
//  Created by 소현 on 11/5/23.
//

/**
 서버에서 조회한 시간 정보 데이터 모델.
 ServerModel 또는 Entity 정도로 표현할 수 있음.
 */
 
import Foundation

struct UTCDateModel: Codable {
    let id: String
    let currentDateTime: String // 앱에서 사용할 데이터.
    let utcOffset: String
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: String
    let timeZoneName: String
    let currentFileTime: Int64
    let ordinalDate: String
    let serviceResponse: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case currentDateTime
        case utcOffset
        case isDayLightSavingsTime
        case dayOfTheWeek
        case timeZoneName
        case currentFileTime
        case ordinalDate
        case serviceResponse
    }
}
