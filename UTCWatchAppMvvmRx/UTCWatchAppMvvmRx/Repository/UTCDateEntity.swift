//
//  UTCDateEntity.swift
//  UTCWatchApp
//
//  Created by 소현 on 11/5/23.
//

/**
 서버에서 조회한 시간 정보 데이터 모델.
 ServerModel 또는 Entity 정도로 표현할 수 있음.
 */
 
import Foundation

struct UTCDateEntity: Codable {
    let abbreviation: String
    let clientIp: String
    let datetime: String
    let timezone: String
    let unixtime: UInt64
    let utcDatetime: String // 실제 앱에서 사용할 데이터
    let utcOffset: String
    let weekNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case abbreviation
        case clientIp = "client_ip"
        case datetime
        case timezone
        case unixtime
        case utcDatetime = "utc_datetime"
        case utcOffset = "utc_offset"
        case weekNumber = "week_number"
    }
}
