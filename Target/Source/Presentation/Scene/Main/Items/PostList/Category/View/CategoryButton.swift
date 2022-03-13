//
//  CategoryView.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/18.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import Then

final class CategoryButton: UIButton {
    // MARK: - Properties
    enum Direction {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case centerRight
    }
    private let direction: Direction
    private let major: Major
    private let majorLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 20)
        $0.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        switch direction {
        case .topLeft:
            majorLabel.pin.topLeft(10)
        case .topRight:
            majorLabel.pin.topRight(10)
        case .bottomLeft:
            majorLabel.pin.bottomLeft(10)
        case .bottomRight:
            majorLabel.pin.bottomRight(10)
        case .centerRight:
            majorLabel.pin.centerRight(10)
        }
        majorLabel.pin.sizeToFit()
    }
    // MARK: - Init
    init(
        major: Major,
        direction: Direction,
        backgroundColor: UIColor,
        foregroundColor: UIColor
    ) {
        self.direction = direction
        self.major = major
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        majorLabel.textColor = foregroundColor
        addView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryButton {
    func addView() {
        addSubViews(majorLabel)
    }
    func configureView() {
        self.layer.cornerRadius = 5
        if major == .frontEnd {
            majorLabel.text = "Front\n-End"
            majorLabel.textAlignment = .right
        } else if major == .backEnd {
            majorLabel.text = "Back-End"
        } else {
            majorLabel.text = major.display
        }
    }
}
