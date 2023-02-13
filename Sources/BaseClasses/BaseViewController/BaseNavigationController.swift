//
//  BaseNavigationController.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 5/26/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

public protocol BaseNavigationControllerDelegate: AnyObject {
    func didPopViewController(viewController: UIViewController?)
    func didPopToRootViewController(viewControllers: [UIViewController])
}

open class BaseNavigationController: UINavigationController {
    // Very bad workaround
    weak var coordinator: BaseCoordinator?

    @discardableResult
    public override func popViewController(animated: Bool) -> UIViewController? {
        let poppedVC = super.popViewController(animated: animated)
        let parent = coordinator?.parentCoordinator
        parent?.removeAllChildCoordinators()
        coordinator = parent
        return poppedVC
    }
    @discardableResult
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedVCs = super.popToRootViewController(animated: animated)
        let parent = coordinator?.parentCoordinator
        parent?.removeAllChildCoordinators()
        coordinator = parent
        return poppedVCs
    }
}
