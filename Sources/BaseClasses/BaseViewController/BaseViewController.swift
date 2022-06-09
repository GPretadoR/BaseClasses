//
//  BaseViewController.swift
//  RakutenShop
//
//  Created by Garnik Ghazaryan on 2/6/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import Development_Support
import KRProgressHUD
import UIKit

open class BaseViewController: UIViewController {

    private lazy var topBarImageView = AppImageView {
        $0.backgroundColor = AppColors.clear
        $0.contentMode = .scaleAspectFit
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarStyle()

        KRProgressHUD.set(style: .custom(background: AppColors.appMainThemeColor, text: AppColors.white, icon: AppColors.white))
        KRProgressHUD.set(maskType: .clear)
        KRProgressHUD.set(graceTime: 2.0)
        KRProgressHUD.set(duration: 2.0)

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        setupViewModel()
        setupReactiveComponents()
    }

    public override func loadView() {
        super.loadView()
        setupView()
    }

    public func setupView() {
        setupTexts()
    }

    public func setupViewModel() {}

    public func setupTexts() {
        navigationItem.title = title()
    }

    public func setupReactiveComponents() {}

    public func addCloseButton(on vc: UIViewController, action: Selector) {
        guard let closeImage = UIImage(named: "close") else { return }
        closeImage.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: closeImage.size.width - 1, bottom: 0, right: 0))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: action)
    }

    private func navigationBarStyle() {
        guard let navigationController = navigationController else { return }
        guard let backButtonBackgroundImage = UIImage(named: "back") else { return }
        backButtonBackgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: backButtonBackgroundImage.size.width - 1, bottom: 0, right: 0))

        navigationController.navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        navigationController.navigationBar.tintColor = AppColors.black

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppColors.black
        navigationItem.backBarButtonItem?.setTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 12.0), for: UIBarMetrics.default)
    }

    private func title() -> String {
        let words = String(describing: Self.self).splitWord()
        return words.filter { $0 != "View" && $0 != "Controller" }.joined(separator: " ")
    }
}
