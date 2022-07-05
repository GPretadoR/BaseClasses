//
//  AppButton.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/9/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

public enum AppButtonStyle {
    case plain
    case filled
    case bordered
    case filledWithIcon
    case borderedWithIcon
}

open class AppButton: BaseButton {
    
    public var imageRenderingMode: UIImage.RenderingMode = .alwaysOriginal

    public init(style: AppButtonStyle) {
        super.init(frame: .zero)
        setup(with: style)
        configureDefaultValues()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaultValues()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override open var icon: UIImage? {
        didSet {
            let tintedImage = icon?.withRenderingMode(imageRenderingMode)
            setImage(tintedImage, for: .normal)
        }
    }

    private func configureDefaultValues() {
        tintColor = AppColors.appMainThemeColor
    }

    open func style(for style: TextsStyles) {
        guard let textStyle = TextsStyles(style: style)?.style else { return }
        textColor = textStyle.textColor ?? .systemBlue
        titleLabel?.font = textStyle.font
    }

    open func style(for style: TextsStyles, color: UIColor) {
        guard let textStyle = TextsStyles(style: style)?.style else { return }
        textColor = color
        titleLabel?.font = textStyle.font
    }

    private func setup(with style: AppButtonStyle) {
        super.setup()
        switch style {
        case .bordered:
            makeBorderedButton()
        case .borderedWithIcon:
            makeBorderedWithIconButton()
        default:
            break
        }
    }

    private func makeBorderedButton() {
        borderWidth = 1.5
        contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        titleLabel?.textAlignment = .center
    }

    private func makeBorderedWithIconButton() {
        borderWidth = 1.5
        contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        titleLabel?.textAlignment = .center
    }
}
