//
//  AppTextField.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/13/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

public class AppTextField: BaseTextField {

    public var oldText: String?

    override public var text: String? {
        didSet {
            oldText = oldValue
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func style(for style: TextsStyles) {
        let textStyle = TextsStyles(style: style)?.style
        self.font = textStyle?.font
        self.textColor = textStyle?.textColor
    }

    public func style(for style: TextsStyles, color: UIColor) {
        let textStyle = TextsStyles(style: style)?.style
        self.font = textStyle?.font
        self.textColor = color
    }
}
