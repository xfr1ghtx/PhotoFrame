//
//  PhotoCollectionViewCellViewModel.swift
//  photoFrame
//
//  Created by developer on 24.08.2022.
//

import Foundation
import PhotosUI

final class PhotoCollectionViewCellViewModel{
    
    let imageProvider: NSItemProvider
    
    var isLoaded = false
    
    var image: UIImage?
    
    init(imageProvider: NSItemProvider){
        self.imageProvider = imageProvider
    }
    
    func prepare(){
        imageProvider.loadObject(ofClass: UIImage.self) { [weak self] result, err in
            guard let resultImage = result as? UIImage, err == nil else{
                return
            }
            self?.image = resultImage
            self?.isLoaded = true
        }
    }
    
    func getImage() -> UIImage{
        let returnImage = image
        image = nil
        return returnImage ?? UIImage()
    }
    

}
