//
//  OtmTextField.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/3/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class OtmTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
//        tintColor = UIColor.white
//        backgroundColor = UIColor.primaryLight
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.size.width - 16, height: bounds.size.height)
        return insetBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.size.width - 16, height: bounds.size.height)
        return insetBounds
    }
    
}
