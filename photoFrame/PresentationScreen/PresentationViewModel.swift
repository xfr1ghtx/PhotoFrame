//
//  PresentationViewModel.swift
//  photoFrame
//
//  Created by developer on 24.08.2022.
//

import Foundation

final class PresentationViewModel {
    
    let cellViewModels: [PhotoCollectionViewCellViewModel]
    
    init(providers: [NSItemProvider]){
        cellViewModels = providers.map{PhotoCollectionViewCellViewModel.init(imageProvider: $0)}
        cellViewModels.first?.prepare()
    }
}
