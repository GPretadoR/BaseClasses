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
        interactivePopGestureRecognizer?.addTarget(self, action: #selector(handleSwipeGesture))
    }

    @objc func handleSwipeGesture(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .ended:
            print("Swipe ended")
        case .cancelled, .failed:
//            isSwipeCancelled = true
            print("Swipe cancelled")
        case .began:
            print("Swipe began")
        case .possible:
            print("Swipe possible")
        case .recognized:
            print("Swipe recognized")
        case .changed:
            print("Swipe changed")
        default:
            break
        }
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
