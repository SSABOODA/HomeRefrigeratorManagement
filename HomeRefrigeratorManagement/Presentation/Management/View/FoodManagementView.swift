//
//  FoodManagementView.swift

import UIKit
import SnapKit
import Then

final class FoodManagementView: BaseView {
    
    let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "냉장고에 저장된 식품을 검색해보세요".localized,
            attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 11)!]
        )
        
        $0.searchBar.showsCancelButton = true
        $0.searchBar.setShowsCancelButton(false, animated: true)
        
        if let cancelButton = $0.searchBar.value(forKey: "cancelButton") as? UIButton {
            let nsAttributedString = NSAttributedString(
                string: "취소".localized,
                attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 12)!]
            )
            cancelButton.setTitleColor(Constant.BaseColor.tintColor, for: .normal)
            cancelButton.setAttributedTitle(nsAttributedString, for: .normal)
        }
    }
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: createLayout()).then {
        $0.register(
            FoodManagementCollectionViewHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FoodManagementCollectionViewHeaderView.description()
        )
    }
    
    let foodRegisterButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.setTitle("보관하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: Constant.Font.pretendardSemiBold, size: 16)
        $0.tintColor = .white
        $0.backgroundColor = Constant.BaseColor.basePointOrangeHexColor
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    let emptyView = EmptyView().then { _ in }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setupHierarchy() {
        addSubview(collectionView)
        addSubview(foodRegisterButton)
        addSubview(emptyView)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        foodRegisterButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(20)
        }
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.3)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20)

            let titleSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(Constant.ScreenSize.deviceScreenHeight*0.1)
            )
            
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: FoodManagementViewController.description(),
                alignment: .top
            )
            titleSupplementary.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: config
        )
        
        return layout
    }
}

