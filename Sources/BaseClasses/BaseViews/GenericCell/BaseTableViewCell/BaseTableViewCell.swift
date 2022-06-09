//
//  BaseTableViewCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/5/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import UIKit

open class BaseTableViewCell: UITableViewCell {

    open override func awakeFromNib() {
        super.awakeFromNib()
        guard let label = textLabel as? AppLabel else { return }
        setStyle(label: label, style: .none)
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    open func setStyle(label: AppLabel, style: TextsStyles) {
        label.style(for: style)
    }
}
