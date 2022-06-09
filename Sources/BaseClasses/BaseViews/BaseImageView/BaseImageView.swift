//
//  BaseImageView.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/12/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

open class BaseImageView: UIImageView {
    open var hasShadow: Bool = false {
        didSet {
            if self.hasShadow {
                self.addCornerRadiusAndShadow(cornerRadius: layer.cornerRadius,
                                              shadowColor: AppColors.black,
                                              shadowOffset: CGSize(width: 0.0, height: 6.0),
                                              shadowRadius: layer.cornerRadius,
                                              shadowOpacity: 0.25)
            }
        }
    }
}
