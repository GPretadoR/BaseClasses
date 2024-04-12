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
    weak var coordinator: NavCoordinator?

    var isInteractivePop: Bool = false

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.addTarget(self, action: #selector(handleSwipeBack))
    }

    @objc func handleSwipeBack() {
        isInteractivePop = true
    }

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
//        interactivePopGestureRecognizer?.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public override func popViewController(animated: Bool) -> UIViewController? {
        let poppedVC = super.popViewController(animated: animated)
        coordinator?.pop(animated: animated)
        return poppedVC
    }
    
    @discardableResult
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedVCs = super.popToRootViewController(animated: animated)
        coordinator?.popToRoot(animated: animated, completion: nil)
        return poppedVCs
    }

    func popCoordinator() {
//        let parent = coordinator?.parentCoordinator
//        parent?.removeAllChildCoordinators()
////        coordinator = parent
    }
}

//extension BaseNavigationController: UIGestureRecognizerDelegate {
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let parent = coordinator?.parentCoordinator
//        parent?.removeAllChildCoordinators()
//        coordinator = parent
//        return true
//    }
//}
