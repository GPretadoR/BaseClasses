//
//  PinTextField.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 2/17/19.
//  Copyright © 2019 Garnik Ghazaryan. All rights reserved.
//

import UIKit

public protocol PinTextFieldDelegate: UITextFieldDelegate {
    func textField(_ textField: UITextField, didDeleteBackward wasEmpty: Bool)
}

open class PinTextField: AppTextField {

    override open func deleteBackward() {
        // see if text was empty
        let wasEmpty = text == nil || text?.isEmpty ?? true

        // then perform normal behavior
        super.deleteBackward()

        // now, notify delegate (if existent)
        (delegate as? PinTextFieldDelegate)?.textField(self, didDeleteBackward: wasEmpty)
    }
}
