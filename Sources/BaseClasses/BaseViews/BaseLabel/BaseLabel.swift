//
//  BaseLabel.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

open class BaseLabel: UILabel {

    open var textInsets: UIEdgeInsets = UIEdgeInsets.zero

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    open override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += textInsets.top + textInsets.bottom
        contentSize.width += textInsets.left + textInsets.right
        return contentSize
    }
}
