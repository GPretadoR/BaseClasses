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
//    var isSwipeCancelled: Bool = false

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public override func popViewController(animated: Bool) -> UIViewController? {
        let poppedVC = super.popViewController(animated: animated)


        print("Swipe POPPED", poppedVC)
//        if let coordinatorVC = coordinator?.controller,
//           poppedVC == coordinatorVC,
//           var coordinator,
//           let parent = coordinator.parentCoordinator {
//
//            parent.removeChildCoordinator(coordinator)
//            coordinator = parent
//        }
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
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("Swipe Will Show", viewController)
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("Swipe Did Show", viewController)
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("Swipe From VC", fromVC)
        print("Swipe TO VC", toVC)
        return nil
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let parent = coordinator?.parentCoordinator
//        parent?.removeAllChildCoordinators()
//        coordinator = parent
//        switch gestureRecognizer.state {
//        case .ended:
//            print("Swipe ended")
//        case .cancelled, .failed:
////            isSwipeCancelled = true
//            print("Swipe cancelled")
//        case .began:
//            print("Swipe began")
//        case .possible:
//            print("Swipe possible")
//        case .recognized:
//            print("Swipe recognized")
//        case .changed:
//            print("Swipe changed")
//        default:
//            break
//        }
        return true
    }
}
