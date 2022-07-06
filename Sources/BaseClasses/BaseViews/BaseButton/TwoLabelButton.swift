//
//  TwoLabelButton.swift
//  ANIV
//
//  Created by Garnik Ghazaryan on 29.05.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import Development_Support
import UIKit

open class TwoLabelButton: BaseButton {

    private var leftSideLabel = AppLabel {
        $0.style(textStyle: .regular(18), color: AppColors.appDarkGrayColor)
    }

    private var rightSideLabel = AppLabel {
        $0.style(textStyle: .regular(18), color: AppColors.appDarkGrayColor)
    }

    open override func setup() {
        super.setup()
        addSubview(leftSideLabel)
        addSubview(rightSideLabel)

        NSLayoutConstraint.activate([leftSideLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     leftSideLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)])

        NSLayoutConstraint.activate([rightSideLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     rightSideLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)])

    }

    open func configure(leftTitle: String? = nil, rightTitle: String? = nil) {
        leftSideLabel.text = leftTitle ?? leftSideLabel.text
        rightSideLabel.text = rightTitle ?? rightSideLabel.text
    }

    open func configureStyle(leftLabelStyle: TextsStyles, color: UIColor) {
        leftSideLabel.style(textStyle: leftLabelStyle, color: color)
    }

    open func configureStyle(rightLabelStyle: TextsStyles, color: UIColor) {
        rightSideLabel.style(textStyle: rightLabelStyle, color: color)
    }
}
