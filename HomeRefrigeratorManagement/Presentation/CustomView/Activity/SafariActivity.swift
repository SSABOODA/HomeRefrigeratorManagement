//
//  SafariActivity.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/13.
//

import UIKit

protocol CustomActivityDelegate : NSObjectProtocol {
    func performActionCompletion(actvity: SafariActivity)
}

final class SafariActivity: UIActivity {
    weak var delegate: CustomActivityDelegate?
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override var activityType: UIActivity.ActivityType? {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            return nil
        }
        
        return UIActivity.ActivityType(rawValue: bundleId + "\(self.classForCoder)")
    }
    
    override var activityTitle: String? {
        return "Open in Safari"
    }
    
    override var activityImage: UIImage? {
        return UIImage(systemName: "safari")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {}
    
    override func perform() {
        self.delegate?.performActionCompletion(actvity: self)
        activityDidFinish(true)
    }
}

