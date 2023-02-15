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
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        interactivePopGestureRecognizer?.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension BaseNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let parent = coordinator?.parentCoordinator
        parent?.removeAllChildCoordinators()
        coordinator = parent
        return true
    }
}
