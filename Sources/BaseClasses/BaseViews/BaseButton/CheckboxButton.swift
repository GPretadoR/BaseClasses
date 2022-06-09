//
//  CheckboxButton.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 8/31/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

public class CheckboxButton: BaseButton {

    public var selectedIcon: UIImage? {
        didSet {
            let tintedImage = selectedIcon?.withRenderingMode(.alwaysTemplate)
            setBackgroundImage(tintedImage, for: .selected)
        }
    }

    public var deselectedIcon: UIImage? {
        didSet {
            setBackgroundImage(deselectedIcon, for: .normal)
        }
    }

    public var checkBoxDidChange: ((Bool) -> Void)?

    override public func setup() {
        super.setup()
        addTarget(self, action: #selector(checkBoxTapped(_ :)), for: .touchUpInside)
        configureDefaultValues()
    }

    private func configureDefaultValues() {
        tintColor = AppColors.appMainThemeColor
    }

    @objc private func checkBoxTapped(_ sender: Any) {
        isSelected = !isSelected
        checkBoxDidChange?(isSelected)
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -10, dy: -10).contains(point)
    }
}
