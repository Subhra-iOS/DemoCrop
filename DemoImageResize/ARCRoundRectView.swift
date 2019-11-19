//
//  ARCRoundRectView.swift
//  DemoImageResize
//
//  Created by Subhra Roy on 19/11/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

class ARCRoundRectView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
     override func layoutSubviews() {
           super.layoutSubviews()
            self.roundCorners([.topLeft, .bottomLeft], radius: 5.0)
       }

}

extension UIView {
 
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
 
}
