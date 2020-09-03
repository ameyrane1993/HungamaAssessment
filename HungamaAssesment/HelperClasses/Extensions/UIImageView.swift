//
//  UIImageView.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum ImageType {
    case original
    case portrait
    case youtube
}


extension UIImageView {
    
    func loadImage(_ imgURL: String?, type: ImageType) {
        
        let imageURL = getImageURL(imageURL: imgURL ?? "", type: type)
        
        guard let imageURLString: String = imageURL else {
            self.image = UIImage(named: "placeholder")
            return
        }
        if imageURLString == "" {
            self.image = UIImage(named: "placeholder")
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "placeholder")
            }
        }
    }
    
    func getImageURL(imageURL: String, type: ImageType) -> String {
        var imgURL = imageURL
        if type == .original {
            imgURL = "\(WebServiceMethods.WS_IMAGE_BASE_URL)original\(imageURL)"
        }else if type == .portrait {
            imgURL = "\(WebServiceMethods.WS_IMAGE_BASE_URL)w300\(imgURL)"
        }else{
            imgURL = "\(WebServiceMethods.WS_IMAGE_YOUTUBE_URL)\(imgURL)/0.jpg"
        }
        
        return imgURL
    }
}

