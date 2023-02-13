//
//  CheckboxButton.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 8/31/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

open class CheckboxButton: BaseButton {

    open var selectedIcon: UIImage? {
        didSet {
            setBackgroundImage(selectedIcon, for: .selected)
        }
    }

    open var deselectedIcon: UIImage? {
        didSet {
            setBackgroundImage(deselectedIcon, for: .normal)
        }
    }

    open var checkBoxDidChange: ((Bool) -> Void)?

    override open func setup() {
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

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -10, dy: -10).contains(point)
    }
}
