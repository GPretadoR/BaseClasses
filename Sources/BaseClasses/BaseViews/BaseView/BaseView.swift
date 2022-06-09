//
//  BaseView.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/4/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import Development_Support
import UIKit

open class BaseView: UIView {

    public init() {
        super.init(frame: .zero)
        setupView()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    public func setupView() {}

    public var hasShadow: Bool = false {
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
