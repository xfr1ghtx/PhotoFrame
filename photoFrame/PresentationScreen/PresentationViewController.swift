//
//  PresentationViewController.swift
//  photoFrame
//
//  Created by developer on 24.08.2022.
//

import UIKit

final class PresentationViewController: UIViewController {
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(tapOnExitButton), for: .touchUpInside)
        button.tintColor = .systemGray6
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var timer: Timer?
    private var currentIndex = 0
    
    private let viewModel: PresentationViewModel
    
    init(viewModel: PresentationViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        timer = .scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNextPhoto), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            self?.view.backgroundColor = .black
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    private func setup(){
        view.addSubview(photosCollectionView)
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            exitButton.heightAnchor.constraint(equalToConstant: 44),
            exitButton.widthAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    @objc
    private func tapOnExitButton(){
        dismiss(animated: true)
    }
    
    @objc
    private func slideToNextPhoto(){
        if currentIndex < (viewModel.cellViewModels.count) - 1 {
            currentIndex += 1
        } else {
            dismiss(animated: true)
        }
        photosCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }
}

extension PresentationViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photosCollectionView.bounds.width, height: photosCollectionView.bounds.height)
    }
}

extension PresentationViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let nextViewModel = indexPath.row < viewModel.cellViewModels.count - 1 ? viewModel.cellViewModels[indexPath.row + 1] : nil
        
        cell.configure(currentViewModel: viewModel.cellViewModels[indexPath.row], nextViewModel: nextViewModel)
        
        
        return cell
    }
    
}
