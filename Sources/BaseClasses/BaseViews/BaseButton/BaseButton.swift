//
//  BaseButton.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/6/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

public enum ButtonStyle {
    case fill
    case border
    case fillAndIcon
    case borderAndIcon
}

open class BaseButton: UIButton {

    open var titleText: String? {
        didSet {
            setTitle(titleText, for: .normal)
        }
    }

    open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    open var textColor: UIColor = .blue {
        didSet {
            setTitleColor(textColor, for: .normal)
        }
    }

    open var highlightedTextColor: UIColor = .lightGray {
        didSet {
            setTitleColor(highlightedTextColor, for: .highlighted)
        }
    }

    open var icon: UIImage? {
        didSet {
            setImage(icon, for: .normal)
        }
    }

    open var backgroundImage: UIImage? {
        didSet {
            setBackgroundImage(backgroundImage, for: .normal)
        }
    }

    open var highLightedIcon: UIImage? {
        didSet {
            setImage(highLightedIcon, for: .highlighted)
        }
    }

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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    open func setup() {
        layer.cornerRadius = 6
        highlightedTextColor = AppColors.gray
    }

    private func setBackgroundColor(color: UIColor?, for state: UIControl.State) {
        guard let color = color else { return }
        setBackgroundImage(UIImage(ciImage: CIImage(color: CIColor(cgColor: color.cgColor))), for: state)
    }
}
