//
//  CustomViews.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 11.04.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit

@IBDesignable class CustomViews: UIView {

   
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    
    
    
    
    
    
    
}
