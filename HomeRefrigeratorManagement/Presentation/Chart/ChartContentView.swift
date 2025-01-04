//
//  CharContentView.swift

import UIKit

final class ChartContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Constant.BaseColor.backgroundColor
        layer.cornerRadius = 10
        clipsToBounds = false
    }
    
    
}
