//
//  StartViewController.swift
//  photoFrame
//
//  Created by developer on 24.08.2022.
//

import UIKit
import PhotosUI

final class StartViewController: UIViewController {
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "PhotoFrame"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Click the START button,\nselect photos and enjoy watching them"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: StartViewModel
    
    init(viewModel: StartViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        bindToViewModel()
    }
    
    private func bindToViewModel(){
        viewModel.didGoToNextScreen = {[weak self] vc in
            self?.present(vc, animated: true)
        }
    }
    
    private func setup(){
        stackView.addArrangedSubview(appNameLabel)
        stackView.addArrangedSubview(appDescriptionLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    override public var shouldAutorotate: Bool {
       return false
    }
    
    @objc
    private func didTapStartButton(){
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 0
        config.filter = .images
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }

}

extension StartViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        viewModel.selectedPhotosDone(imageProviders: results.map{$0.itemProvider})
    }
    
    
}

