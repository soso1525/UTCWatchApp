//
//  UTCDate.swift
//  UTCWatchAppMvvm
//
//  Created by 소현 on 11/11/23.
//

/**
 service(logic)에서 사용할 model.
 service가 repository를 통해 fetching 해온 entity를 적절히 가공하여
 앱에서 필요한 데이터를 추출하여 서비스 로직 모델인 UTCDate를 만든다.
 */

import Foundation

struct UTCDate {
    let date: Date
}
