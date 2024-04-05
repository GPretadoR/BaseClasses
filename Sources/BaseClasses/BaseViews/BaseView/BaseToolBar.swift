//
//  File.swift
//  
//
//  Created by Garnik Ghazaryan on 4/6/24.
//

import UIKit

public class BaseToolbar: UIToolbar {

    public var onDone: (() -> Void)?

    public init() {
        super.init(frame: .zero)
        sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        setItems([flexibleSpace, doneButton], animated: false)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func doneButtonTapped() {
        if let onDone {
            onDone()
        } else {
            resignFirstResponder()
            endEditing(true)
        }
    }
}
