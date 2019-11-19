//
//  UIImage+Extension.swift
//  DemoImageResize
//
//  Created by Subhra Roy on 17/11/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation
import Accelerate
import UIKit

extension UIImage{
    
    func resizeImage(viewWidth: CGFloat) -> (newImage : UIImage? , newHeight : CGFloat){
      
           let height = (self.size.height * viewWidth )/self.size.width
          let imageViewScale = max(self.size.width / viewWidth,
           self.size.height / height)
        let cropZone = CGRect(x: 0.0 * imageViewScale, y: 0.0 * imageViewScale, width: viewWidth * imageViewScale, height: height * imageViewScale)

            // Perform cropping in Core Graphics
            guard let cutImageRef: CGImage = self.cgImage?.cropping(to:cropZone)
            else {
                return (newImage : nil , newHeight :  0.0)
            }

            // Return image to UIImage
            let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
            return (newImage : croppedImage , newHeight :  height)
        }
    
    func cropImage(toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> (newImage : UIImage? , newHeight : CGFloat){
        
            let imageViewScale = max(self.size.width / viewWidth,
                                     self.size.height / viewHeight)

            // Scale cropRect to handle images larger than shown-on-screen size
            let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                                  y:cropRect.origin.y * imageViewScale,
                                  width:cropRect.size.width * imageViewScale,
                                  height:cropRect.size.height * imageViewScale)

            // Perform cropping in Core Graphics
            guard let cutImageRef: CGImage = self.cgImage?.cropping(to:cropZone)
            else {
                return (newImage : nil , newHeight : 0.0)
            }

            // Return image to UIImage
            let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
            return (newImage : croppedImage , newHeight : cropZone.height)
        }
        
}
