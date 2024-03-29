//
//  baseTableViewCell.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewCell<T>: UITableViewCell{
    let bound = UIScreen.main.bounds
    lazy var disposeBag: DisposeBag = .init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
        configureCell()
        if traitCollection.userInterfaceStyle == .dark { darkConfigure() }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayoutSubviews()
    }
    func addView(){}
    func setLayout(){}
    func setLayoutSubviews(){}
    func configureCell(){}
    var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    func darkConfigure(){}
    func bind(_ model: T){}
}
