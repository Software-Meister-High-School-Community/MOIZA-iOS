//
//  TOSCell.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import M13Checkbox
import RxCocoa

protocol TOSCellDelegate: AnyObject {
    func checkButtonDidTap(isOn: Bool, type: TOSType)
    func detailButtonDidTap(type: TOSType)
}

final class TOSCell: BaseTableViewCell<TOSModel>{
    // MARK: - Properties
    weak var delegate: TOSCellDelegate?
    private let checkButton = M13Checkbox().then {
        $0.markType = .radio
        $0.boxType = .circle
        $0.tintColor = MOIZAAsset.moizaPrimaryYellow.color
        $0.secondaryCheckmarkTintColor = MOIZAAsset.moizaGray1.color
        $0.checkmarkLineWidth = 4
        $0.boxLineWidth = 1
        $0.secondaryTintColor = MOIZAAsset.moizaGray3.color
        $0.stateChangeAnimation = .bounce(.fill)
    }
    private let contentLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    private let detailButton = UIButton().then {
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(checkButton, contentLabel, detailButton)
    }
    override func setLayout() {
        checkButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(22)
        }
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkButton.snp.trailing).offset(8)
        }
        detailButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    override func configureCell() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    override func bind(_ model: TOSModel) {
        contentLabel.text = model.type.rawValue
        checkButton.checkState = model.isOn ? .checked : .unchecked
        
        checkButton.addTarget(self, action: #selector(checkButtonDidTap(_:)), for: .valueChanged)

        detailButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.delegate?.detailButtonDidTap(type: model.type)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Action
    @objc func checkButtonDidTap(_ sender: M13Checkbox){
        guard let model = model else { return }
        self.delegate?.checkButtonDidTap(isOn: sender.checkState == .checked, type: model.type)
    }
    
}
