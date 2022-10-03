//
//  GenericTableViewCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/11/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Development_Support
import UIKit

public protocol ReusableView: UIView {
    func prepareForReuse()
}

final public class GenericTableViewCell<View: ReusableView>: BaseTableViewCell {
    public var view = View()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.embed(view: view, insets: .zero)
    }
}
