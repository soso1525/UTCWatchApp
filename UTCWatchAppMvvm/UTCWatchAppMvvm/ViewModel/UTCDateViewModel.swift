//
//  UTCDateViewModel.swift
//  UTCWatchAppMvvm
//
//  Created by 소현 on 11/11/23.
//

/**
 ViewModel은 view에서 사용하는 model로
 여기서는 label에 날짜 정보를 표시하기 때문에 ViewModel의 타입으로 String이 필요하다.
 즉 서비스 로직 모델인 date를 앱에서 원하는 형식의 문자열로 변환해주어야 한다.
 */

import Foundation

class UTCDateViewModel {
    let utcDateService: UTCDateService
    let kstDateFormatter: DateFormatter
    
    init() {
        self.utcDateService = UTCDateService()
        self.kstDateFormatter = DateFormatter()
        self.kstDateFormatter.timeZone = TimeZone(abbreviation: "KST")
        self.kstDateFormatter.locale = Locale(identifier: "ko_KR")
        self.kstDateFormatter.dateFormat = "yyyy년 MM월 dd일 E요일 a hh시 mm분"
    }
    
    private func toKSTDateString(from: UTCDate) -> String {
        return kstDateFormatter.string(from: from.date)
    }
    
    func getToday(completionHandler: @escaping (String) -> Void) {
        self.utcDateService.getToday { [weak self] utcDate in
            guard let self = self else { return }
            completionHandler(self.toKSTDateString(from: utcDate))
        }
    }
    
    func getYesterday() -> String {
        return toKSTDateString(from: utcDateService.getYesterday())
    }
    
    func getTomorrow() -> String {
        return toKSTDateString(from: utcDateService.getTomorrow())
    }
}
