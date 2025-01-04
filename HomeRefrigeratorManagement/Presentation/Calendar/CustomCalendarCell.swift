//
//  CustomCalendarCell.swift

import UIKit
import FSCalendar
import Then

final class CustomCalendarCell: FSCalendarCell {
    var mainImageView = UIImageView().then {
        $0.backgroundColor = .red
        $0.layer.addBorder([.bottom], color: .black, width: 1)
        $0.image = UIImage(systemName: "star")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImageView)
        
        mainImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(10)
        }
    }
    
    override func configureAppearance() {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.backgroundColor = .red
        mainImageView.layoutIfNeeded()
    }
    
    @available(*, unavailable)
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀에 표시할 내용을 설정할 수 있습니다.
    func configureCell(date: Date, calendar: FSCalendar) {
        if calendar.selectedDates.contains(date) {
            mainImageView.image = UIImage(systemName: "star")
        } else {
            mainImageView.isHidden = true
        }
    }
}
