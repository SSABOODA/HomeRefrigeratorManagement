//
//  NewFoodRegisterDetailViewController.swift

import UIKit

final class NewFoodRegisterDetailViewController: BaseViewController {
    
    private let mainView = NewFoodRegisterDetailView()
    private var viewModel: NewFoodRegisterDetailViewModel?
    private let picker = UIPickerView()
    private var senderTag = 0
    
    init(viewModel: NewFoodRegisterDetailViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupTapGestures()
//        configureInitialDate()
//        addTarget()
//        configPickerView()
//        textFieldDelegate()
    }
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    
    private func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.title = "보관하기"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constant.Font.pretendardSemiBold, size: 16) ?? .boldSystemFont(ofSize: 16)
        ]
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
    
    private func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    private func configureInitialDate() {
    }
    
    @objc
    func saveButtonTapped() {
        print("저장하기")
    }
    
    @objc
    func viewTapGesture() {
        view.endEditing(true)
    }
}

