//
//  RecipeCollectionViewCell.swift

import UIKit
import Then

final class RecipeCollectionViewCell: BaseCollectionViewCell {
    
    lazy var mainImageView = UIImageView().then {
        self.addSubview($0)
    }
    let titleLabel = UILabel().then { _ in }
    let descLabel = UILabel().then { _ in }
        
    override func configureHierarchy() {
    }
    
    override func configureLayout() {
        
    }

}

