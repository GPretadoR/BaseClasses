//
//  BaseCoordinator.swift
//  MVVM-C-Networking
//
//  Created by Garnik Ghazaryan on 1/22/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

open class BaseCoordinator: Coordinator {

    public var context: ContextProtocol?

    public weak var parentCoordinator: BaseCoordinator?
    public var childCoordinators: [BaseCoordinator] = []

    public var controller: UIViewController?

    public init() {}

    public init(context: ContextProtocol, root controller: UIViewController?) {
        self.context = context
        self.controller = controller
    }

    public init(coordinator: BaseCoordinator, viewController: BaseViewController) {
        context = coordinator.context
        controller = viewController
    }

    open func start() {}

    public func changeCoordinatorsRoot(coordinator: BaseCoordinator) {
        var currentCoordinator = self
        while currentCoordinator.parentCoordinator != nil {
            currentCoordinator.removeAllChildCoordinators()
            if let parentCoordinator = currentCoordinator.parentCoordinator {
                currentCoordinator = parentCoordinator
            } else {
                break
            }
        }
        currentCoordinator.removeAllChildCoordinators()
        currentCoordinator.addChildCoordinator(coordinator)
    }

    public func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        let vc = presentable.present()
        controller?.present(vc, animated: animated, completion: completion)
    }

    public func dismissModal(animated: Bool, completion: (() -> Void)? = nil) {
        guard let controller = controller else { return }
        controller.dismiss(animated: animated, completion: completion)
        parentCoordinator?.removeAllChildCoordinators()
    }

    public func dismissModal(animated: Bool, childCoordinator: BaseCoordinator, completion: (() -> Void)? = nil) {
        guard let controller = controller else { return }
        controller.dismiss(animated: animated, completion: completion)
        parentCoordinator?.removeChildCoordinator(childCoordinator)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        guard let controller = controller else { return }

        var currentCoordinator = self
        while controller == currentCoordinator.controller {
            currentCoordinator.removeAllChildCoordinators()
            if let parentCoordinator = currentCoordinator.parentCoordinator {
                currentCoordinator = parentCoordinator
            } else {
                break
            }
        }
        currentCoordinator.removeAllChildCoordinators()

        DispatchQueue.main.async {
            controller.dismiss(animated: animated, completion: completion)
        }

        let childrens = controller.children
        childrens.forEach { vc in
            vc.removeFromParent()
        }
    }

    public func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }

    public func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    public func transaction(with completion: (() -> Void)?, action: () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        action()
        CATransaction.commit()
    }
}

extension BaseCoordinator: Equatable {
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
