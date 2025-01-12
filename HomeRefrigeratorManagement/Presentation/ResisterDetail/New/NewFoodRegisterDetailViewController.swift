//
//  NewResi.swift

import UIKit

final class NewFoodRegisterDetailView: BaseView {
    
}

final class NewFoodRegisterDetailViewModel {
    
}

final class NewFoodRegisterDetailViewController: BaseViewController {
    
    let mainView = NewFoodRegisterDetailView()
    private var viewModel: NewFoodRegisterDetailViewModel?
    
    init(viewModel: NewFoodRegisterDetailViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func setupViews() {
        super.setupViews()
        navigationItem.title = "보관하기"
    }
}

