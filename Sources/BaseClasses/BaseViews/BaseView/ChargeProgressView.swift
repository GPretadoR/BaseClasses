//
//  ChargeProgressView.swift
//  YerevanRide
//
//  Created by Garnik Ghazaryan on 7/4/19.
//  Copyright © 2019 Garnik Ghazaryan. All rights reserved.
//

import AppCustomization
import Development_Support
import UIKit

open class ChargeProgressView: UIProgressView {
    @IBInspectable var barHeight: CGFloat = 16
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var thumbImage: UIImage = UIImage()

    open var borderColor: UIColor = AppColors.white {
        didSet {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 1.0
        }
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        addThumbIcon()
    }

    override open var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: barHeight)
    }

    private func addThumbIcon() {
        let thumbImageView = UIImageView(image: thumbImage)
        if let progressImageView = self.subviews.last {
            thumbImageView.frame.origin = CGPoint(x: progressImageView.bounds.size.width - thumbImageView.frame.size.width, y: progressImageView.bounds.origin.y)
            if progressImageView.subviews.count != 0 {
                progressImageView.subviews.forEach { $0.removeFromSuperview() }
            }
            progressImageView.roundCorners(corners: [.topRight, .bottomRight], radius: cornerRadius)
            if thumbImageView.frame.size != .zero {
                progressImageView.addSubview(thumbImageView)
            }
        }
    }
}
