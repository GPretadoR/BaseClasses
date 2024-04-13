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

    private var isPoppingViewController: Bool = false

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        isPoppingViewController = false
    }

    @discardableResult
    public override func popViewController(animated: Bool) -> UIViewController? {
        let poppedVC = super.popViewController(animated: animated)
        isPoppingViewController = true
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

extension BaseNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if isPoppingViewController {
            let parent = coordinator?.parentCoordinator
            parent?.removeAllChildCoordinators()
            coordinator = parent
            isPoppingViewController = false
        }
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
