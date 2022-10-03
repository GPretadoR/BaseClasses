//
//  GenericCollectionViewCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 8/26/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Development_Support
import UIKit

final public class GenericCollectionViewCell<View: ReusableView>: BaseCollectionViewCell {
    public var view = View()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }

    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(view)

        embed(view: view, insets: .zero)
        
    }
}
