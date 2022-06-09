//
//  AppImageView.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 4/8/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

public class AppImageView: BaseImageView {

    public var imageRenderingMode: UIImage.RenderingMode = .alwaysTemplate

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaultValues()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    /// Image with ability to change colors. Use 'image' property for original icon color
    public var tintableImage: UIImage? {
        get {
            image
        }
        set {
            let tintableImage = newValue?.withRenderingMode(imageRenderingMode)
            image = tintableImage
        }
    }

    private func configureDefaultValues() {
        tintColor = AppColors.appMainThemeColor
    }
}
