//
//  UTCDateRepository.swift
//  UTCWatchAppMvvm
//
//  Created by 소현 on 11/11/23.
//

/**
 서버에서 표현하는 데이터 모델을 보통 Entity라고 하며
 Repository에서 Entity 데이터를 가져온다.
 
 Entity = UTCDateModel
 Repository = UTCDateRepository
 */

import Foundation

class UTCDateRepository {
    func fetchCurrentDate(completionHandler: @escaping (UTCDateEntity) -> Void) {
         let url = URL(string: "http://worldclockapi.com/api/json/utc/now")!
        
        // All parameters in comletion handler are optional.
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard self != nil else { return } // 순환참조 방지
            guard error == nil else { return }
            
            if let response = response,
               let urlResponse = response as? HTTPURLResponse,
               !(200..<300).contains(urlResponse.statusCode) { return }
            guard let data = data else { return }
            
            let utcDateEntity = try! JSONDecoder().decode(UTCDateEntity.self, from: data)
            completionHandler(utcDateEntity)
        }.resume()
    }
    
}
 
