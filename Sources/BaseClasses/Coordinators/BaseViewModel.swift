//
//  BaseViewModel.swift
//  RakutenShop
//
//  Created by Garnik Ghazaryan on 2/13/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Combine

open class BaseViewModel {
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String = ""
    @Published public var successMessage: String = ""

    public var cancellable = Set<AnyCancellable>()

    public init() {}
    
    open func setupReactiveComponents() {}
}
