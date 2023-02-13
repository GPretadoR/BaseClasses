//
//  NavCoordinator.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 5/25/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import UIKit

open class NavCoordinator: BaseCoordinator {

    private(set) var navigationController: BaseNavigationController
    public weak var navigationPresentingController: UIViewController?

    public init(context: ContextProtocol, root controller: BaseNavigationController) {
        navigationController = controller
        super.init(context: context, root: controller)
    }

    public init(coordinator: NavCoordinator, viewController: BaseViewController) {
        navigationController = coordinator.navigationController
        super.init(coordinator: coordinator, viewController: viewController)
    }

    // MARK: - Overrides

    // MARK: -

    public func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.coordinator = self
            navigationController.pushViewController(viewController, animated: animated)
            navigationPresentingController = viewController
        }
    }

    public func replace(with viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.setViewControllers(
                navigationController.viewControllers.dropLast() + [viewController],
                animated: animated)
            navigationPresentingController = viewController
        }
    }

    public func set(_ viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.setViewControllers(
                viewControllers,
                animated: animated)
            navigationPresentingController = viewControllers.last
        }
    }

    public func pop(animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            _ = navigationController.popViewController(animated: animated)
            parentCoordinator?.removeChildCoordinator(self)
            navigationController.coordinator = nil
        }
    }

    public func pop(to viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.popToViewController(viewController, animated: animated)
            var currentCoordinator = self
            while viewController != currentCoordinator.navigationPresentingController {
                currentCoordinator.removeAllChildCoordinators()
                if let parentCoordinator = currentCoordinator.parentCoordinator as? NavCoordinator {
                    currentCoordinator = parentCoordinator
                }
            }
            currentCoordinator.removeAllChildCoordinators()
            navigationController.coordinator = nil
        }
    }

    public func popControllerToType<T>() -> T? {
        for controller in navigationController.viewControllers {
            if let theController = controller as? T {
                navigationController.popToViewController(controller, animated: false)
                navigationController.coordinator = nil
                return theController
            }
        }
        return nil
    }

    public func findParentCoordinatorByType<T>() -> T? {
        var baseCoordinator = parentCoordinator

        while baseCoordinator != nil {
            if let matchedCoordinator = baseCoordinator as? T {
                return matchedCoordinator
            }
            baseCoordinator = baseCoordinator?.parentCoordinator
        }
        return nil
    }

    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
        transaction(with: completion) {
            navigationController.popToRootViewController(animated: animated)
            navigationController.coordinator = nil
        }
    }
}
