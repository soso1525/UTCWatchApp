//
//  UTCDateService.swift
//  UTCWatchAppMvvm
//
//  Created by 소현 on 11/11/23.
//

import Foundation

class UTCDateService {
    var utcDate: UTCDate
    let utcDateRepository: UTCDateRepository
    
    init() {
        self.utcDate = UTCDate(date: Date())
        self.utcDateRepository = UTCDateRepository()
    }
    
    func getToday(completionHandler: @escaping (UTCDate) -> Void) {
        utcDateRepository.fetchCurrentDate {[weak self] utcDateEntity in
            guard let self = self else { return }
            let date = parseDate(from: utcDateEntity.utcDatetime)
            self.utcDate = UTCDate(date: date)
            completionHandler(self.utcDate)
        }
    }
    
    private func parseDate(from: String) -> Date {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        utcDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ" // 2023-11-13T16:10:25.616948+00:00.
        return utcDateFormatter.date(from: from)!
    }
    
    func getYesterday() -> UTCDate {
        self.utcDate = moveDate(day: -1)
        return self.utcDate
    }
    
    func getTomorrow() -> UTCDate {
        self.utcDate = moveDate(day: 1)
        return self.utcDate
    }
    
    func moveDate(day: Int) -> UTCDate {
        return UTCDate(date: Calendar.current.date(byAdding: .day, value: day, to: utcDate.date)!) // 오류 발생률 적어서 강제 언래핑.
    }
}
