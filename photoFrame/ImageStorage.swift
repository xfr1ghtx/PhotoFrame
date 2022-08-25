//
//  File.swift
//  photoFrame
//
//  Created by developer on 24.08.2022.
//

import Foundation
import UIKit

final class ImageStorage{
    
    private var dictionary: [Int: UIImage] = [:]
    
    static let shared: ImageStorage = ImageStorage()
    
    private init(){
    }
    
    func addValue(key: Int, value: UIImage){
        dictionary[key] = value
    }
    
    func getValue(key: Int) -> UIImage?{
        let image = dictionary[key]
        dictionary[key] = nil
        return image
    }
}
