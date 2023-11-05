//
//  WatchViewController.swift
//  UTCWatchApp
//
//  Created by 소현 on 11/5/23.
//

import UIKit

class WatchViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator()
    }
    
    private func addActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false //true 일 경우 Frame Base Layout이 됨.
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    // MARK: IBAction
    @IBAction func tapYesterdayButton(_ sender: UIButton) {
        guard let currentDate = currentDate,
              let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else {
            return
        }
        
        self.dateTimeLabel.text = getKstDate(from: yesterday)
        self.currentDate = yesterday
    }
    
    @IBAction func tapTodayButton(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        self.fetchCurrentDateTime()
    }
    
    @IBAction func tapTomorrowButton(_ sender: UIButton) {
        guard let currentDate = currentDate,
              let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else {
            return
        }
        
        self.dateTimeLabel.text = getKstDate(from: tomorrow)
        self.currentDate = tomorrow
    }
    
    private func fetchCurrentDateTime() {
        let url = URL(string: "http://worldclockapi.com/api/json/utc/now")!
        
        // All parameters in comletion handler are optional.
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return } // 순환참조 방지
            guard error == nil else { return }
            
            if let response = response,
               let urlResponse = response as? HTTPURLResponse,
               !(200..<300).contains(urlResponse.statusCode) { return }
            guard let data = data else { return }
            
            let utcTimeModel = try! JSONDecoder().decode(UTCDateModel.self, from: data)
            
            let utcDateFormatter = DateFormatter()
            utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            utcDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'" // 2023-11-05T10:05Z
            self.currentDate = utcDateFormatter.date(from: utcTimeModel.currentDateTime)
            
            guard let currentDate = currentDate else { return }
            
            DispatchQueue.main.async {
                self.dateTimeLabel.text = self.getKstDate(from: currentDate)
                self.activityIndicator.stopAnimating()
            }
            
        }.resume()
    }
    
    private func getKstDate(from: Date) -> String {
        let kstDateFormatter = DateFormatter()
        kstDateFormatter.timeZone = TimeZone(abbreviation: "KST")
        kstDateFormatter.locale = Locale(identifier: "ko_KR")
        kstDateFormatter.dateFormat = "yyyy년 MM월 dd일 E요일 a hh시 mm분"
        return kstDateFormatter.string(from: from)
    }
}

