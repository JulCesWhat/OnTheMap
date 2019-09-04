//
//  OtmButton.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/3/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit

class OtmButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        tintColor = UIColor.white
        backgroundColor = UIColor.primaryLight
    }
    
}
