//
//  WatchViewController.swift
//  UTCWatchApp
//
//  Created by 소현 on 11/5/23.
//

/**
 MVVM 패턴에서 ViewController는 view에 포함되며
 사용자의 액션을 받고 화면에 보여질 데이터를 관찰하고 있다가 변경되는 내용을 업데이트 한다.
 여기에는 오로지 view model을 이용하여 데이터를 표현하기만 하며, 서비스 로직에 대한 코드가 없어야 한다.
 */

import UIKit

class WatchViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let utcDateViewModel = UTCDateViewModel()
    
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
        self.dateTimeLabel.text = utcDateViewModel.getYesterday()
    }
    
    @IBAction func tapTodayButton(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        self.prevButton.isEnabled = false
        self.todayButton.isEnabled = false
        self.nextButton.isEnabled = false
        
        utcDateViewModel.getToday { [weak self] today in
            guard let self = self else { return }
            
            DispatchQueue.main.async { // UI는 Main Thread에서 변경 가능.
                self.dateTimeLabel.text = today
                self.prevButton.isEnabled = true
                self.todayButton.isEnabled = true
                self.nextButton.isEnabled = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func tapTomorrowButton(_ sender: UIButton) {
        self.dateTimeLabel.text = utcDateViewModel.getTomorrow()
    }
}

