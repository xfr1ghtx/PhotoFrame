//
//  StartViewModel.swift
//  photoFrame
//
//  Created by developer on 24.08.2022.
//

import Foundation
import UIKit

final class StartViewModel{
    
    var didGoToNextScreen: ((UIViewController) -> Void)?
    
    init(){
        
    }
    
    func selectedPhotosDone(imageProviders: [NSItemProvider]){
        let vm = PresentationViewModel(providers: imageProviders)
        let vc = PresentationViewController(viewModel: vm)
        vc.modalPresentationStyle = .fullScreen
        didGoToNextScreen?(vc)
    }
}
