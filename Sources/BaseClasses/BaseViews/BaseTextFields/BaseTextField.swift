//
//  BaseTextField.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/13/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

public class BaseTextField: UITextField {

    public var canPerformActionsOnLongPress: Bool = true

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return canPerformActionsOnLongPress
    }
}
