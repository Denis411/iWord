// Data of creation: 26/12/22
// Create by Denis Ulianov aka Денис Александрович Ульянов
// Using Swift 5.0
// Running on macOS 12.5
//
// Copyrights
//
// I do not allow any person to use this piece of software
// for any purposes. 
// This project and source code may use libraries or frameworks that are
// released under various Open-Source licenses. Use of those libraries and
// frameworks are governed by their own individual licenses.

import UIKit
import SnapKit

struct LexicalUnitCellInfo {
    let image: UIImage?
    let progressPercentage: Int8
    let unitOriginalValue: String
    let unitPrimaryTranslation: String
}

fileprivate let UNIT_IMAGE_VIEW_EDGES: CGFloat = 20.0
fileprivate let UNIT_IMAGE_LEFT_INSET: CGFloat = 20.0
fileprivate let PROGRESS_VIEW_EDGE: CGFloat = 40.0
fileprivate let PROGRESS_VIEW_INSET: CGFloat = 20.0
fileprivate let STACK_VIEW_MERGIN: CGFloat = 10.0
fileprivate let SPACING_BETWEEN_LABELS: CGFloat = 10.0

class LexicalUnitTableViewCell: UITableViewCell {
    static let reusableID = "LexicalUnitTableViewCell"
    private let unitImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let unitOriginalValue = UILabel()
    private let unitPrimaryTranslation = UILabel()
    //  TODO: progressView will be a colorful UIView after A B testing
    private let progressView = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setUpCellData(with model: LexicalUnitCellInfo) {
        self.unitImageView.image = model.image
        self.progressView.text = String(model.progressPercentage)
        self.unitPrimaryTranslation.text = model.unitPrimaryTranslation
        self.unitOriginalValue.text = model.unitOriginalValue
    }
}

// set subviews
extension LexicalUnitTableViewCell {
    private func setUpUI() {
        addSubviews()
        setAllConstraints()
        configureAllView()
    }

    private func addSubviews() {
        contentView.addSubview(unitImageView)
        contentView.addSubview(progressView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(unitOriginalValue)
        labelStackView.addArrangedSubview(unitPrimaryTranslation)
    }

    private func setAllConstraints() {
        setUnitImageViewConstraints()
        setProgressViewConstraints()
        setLabelStackViewConstraints()
    }

    private func setUnitImageViewConstraints() {
        unitImageView.snp.makeConstraints { make in
            make.height.width.equalTo(UNIT_IMAGE_VIEW_EDGES)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(UNIT_IMAGE_LEFT_INSET)
        }
    }

    private func setProgressViewConstraints() {
        progressView.snp.makeConstraints { make in
            make.height.width.equalTo(PROGRESS_VIEW_EDGE)
            make.right.equalToSuperview().inset(PROGRESS_VIEW_INSET)
            make.centerY.equalToSuperview()
        }
    }

    private func setLabelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.left.equalTo(unitImageView.snp.left).inset(STACK_VIEW_MERGIN)
            make.right.equalTo(progressView.snp.right).inset(STACK_VIEW_MERGIN)
            make.top.bottom.equalToSuperview().inset(STACK_VIEW_MERGIN)
        }
    }

    private func configureAllView() {
        configureStackView()
        configureUnitOriginalValue()
        configureUnitPrimaryTranslation()
    }

    private func configureStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = SPACING_BETWEEN_LABELS
    }

    private func configureUnitOriginalValue() {
        //      Use R.swift
        //      Use color strategy for colors and font sizes
        unitOriginalValue.font = .systemFont(ofSize: 20)
        unitOriginalValue.numberOfLines = 1
        unitOriginalValue.textColor = .blue
    }

    private func configureUnitPrimaryTranslation() {
        //      Use R.swift
        //      Use color strategy for colors and font sizes
        unitPrimaryTranslation.font = .systemFont(ofSize: 20)
        unitPrimaryTranslation.numberOfLines = 1
        unitPrimaryTranslation.textColor = .blue
    }
}
