//
//  ProfileCircleView.swift
//  Knight Rider
//
//  Created by Michael K. on 8/4/17.
//  Copyright © 2017 MGA. All rights reserved.
//

import UIKit

class ProfileCircleView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        layer.borderWidth = 3
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
}
