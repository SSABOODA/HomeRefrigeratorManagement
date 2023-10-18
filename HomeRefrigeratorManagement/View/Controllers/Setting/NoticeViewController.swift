//
//  NoticeViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/16.
//

import UIKit

final class NoticeViewController: BaseViewController {
    var countdownLabel = UILabel()
     
     var targetDate: Date?
     var timer: Timer?
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.addSubview(countdownLabel)
         view.backgroundColor = .darkGray
         countdownLabel.snp.makeConstraints { make in
             make.center.equalToSuperview()
         }
         
         // 특정 날짜 설정 (예: 2023년 12월 31일)
         let calendar = Calendar.current
         var dateComponents = DateComponents()
         dateComponents.year = 2023
         dateComponents.month = 12
         dateComponents.day = 31
         self.targetDate = calendar.date(from: dateComponents)
         
         // 타이머 시작
//         startTimer()
     }
     
     func startTimer() {
         if let targetDate = targetDate {
             timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                 let currentDate = Date()
                 let timeRemaining = targetDate.timeIntervalSince(currentDate)
                 
                 if timeRemaining > 0 {
                     let hours = Int(timeRemaining / 3600)
                     let minutes = Int((timeRemaining.truncatingRemainder(dividingBy: 3600)) / 60)
                     let seconds = Int(timeRemaining.truncatingRemainder(dividingBy: 60))
                     
                     self.countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                 } else {
                     // 시간 유효 기간이 종료되었을 때 필요한 동작 수행
                     self.countdownLabel.text = "유효 기간 만료"
                     timer.invalidate() // 타이머 중지
                 }
             }
         }
     }
}
