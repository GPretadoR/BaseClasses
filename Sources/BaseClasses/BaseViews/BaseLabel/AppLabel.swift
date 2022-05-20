//
//  AppLabel.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

public class AppLabel: BaseLabel {

    public var allowCopyOnLongPress = false {
        didSet {
            if allowCopyOnLongPress {
                addCopyLongTapGesture()
            }
        }
    }

    override init(frame: CGRect) {
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

    public func style(textStyle: TextsStyles, color: UIColor) {
        let textStyle = TextsStyles(style: textStyle)?.style
        self.font = textStyle?.font
        self.textColor = color
    }

    private func addCopyLongTapGesture() {
        isUserInteractionEnabled = true
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longTapGestureHandler))
        addGestureRecognizer(gesture)
    }

    @objc private func longTapGestureHandler() {
        UIPasteboard.general.string = text
    }
}
