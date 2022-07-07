//
//  Context.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 2/29/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

class Context: ContextProtocol {
    let services: Services? = Services()
}

public protocol ContextProtocol {
    var services: Services? { get }
}
