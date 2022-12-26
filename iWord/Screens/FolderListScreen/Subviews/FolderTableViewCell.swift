// Data of creation: 6/12/22
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

import Foundation
import UIKit
import SnapKit

fileprivate let IMAGE_VIEW_EDGE: CGFloat = 40.0
fileprivate let IMAGE_VIEW_INSET: CGFloat = 20.0
fileprivate let PROGRESS_VIEW_EDGE: CGFloat = 40.0
fileprivate let PROGRESS_VIEW_INSET: CGFloat = 20.0
fileprivate let STACKVIEW_MERGIN: CGFloat = 10.0
fileprivate let SPACING_BETWEEN_LABELS: CGFloat = 10.0

final class FolderTableViewCell: UITableViewCell {
    static let reusableID = "FolderTableViewCell"
    private let folderImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let folderNameLabel = UILabel()
    private let numberOfItemsLabel = UILabel()
    //  TODO: progressView will be a colorful UIView after A B testing
    private let progressView = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setCellData(with model: Folder) {
        self.folderNameLabel.text = model.folderName
        self.numberOfItemsLabel.text = String(model.numberOfItems)
        self.progressView.text = String(model.progressPercentage)
    }
}

// setSubviews
extension FolderTableViewCell {
    private func setUpUI() {
        addSubviews()
        setAllConstraints()
        configureAllView()
        configureAllView()
    }
    
    private func addSubviews() {
        contentView.addSubview(folderImageView)
        contentView.addSubview(progressView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(folderNameLabel)
        labelStackView.addArrangedSubview(numberOfItemsLabel)
    }
    
    private func setAllConstraints() {
        setFolderImageViewConstraints()
        setProgressViewConstraints()
        setLabelStackViewConstraints()
    }
    
    private func setFolderImageViewConstraints() {
        folderImageView.snp.makeConstraints { make in
            make.height.width.equalTo(IMAGE_VIEW_EDGE)
            make.left.equalToSuperview().inset(IMAGE_VIEW_INSET)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setProgressViewConstraints() {
        progressView.snp.makeConstraints { make in
            make.width.equalTo(PROGRESS_VIEW_EDGE)
            make.right.top.bottom.equalToSuperview().inset(PROGRESS_VIEW_INSET)
        }
    }
    
    private func setLabelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(folderImageView)
            make.left.equalTo(folderImageView.snp.right).offset(STACKVIEW_MERGIN)
            //          mark: negative num because of SnapKit bug
            make.right.equalTo(progressView.snp.left).offset(-STACKVIEW_MERGIN)
        }
    }
    
    private func configureAllView() {
        configureFolderImageView()
        configureLabelStackView()
        configureFolderNameLabel()
        configureNumberOfItemsLabel()
    }
    
    private func configureFolderImageView() {
        let folderImage = UIImage(systemName: "folder")!
        folderImageView.contentMode = .center
        folderImageView.image = folderImage
    }
    
    private func configureLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = SPACING_BETWEEN_LABELS
    }
    
    private func configureFolderNameLabel() {
        //      Use R.swift
        //      Use color strategy for colors and font sizes
        folderNameLabel.font = .systemFont(ofSize: 20)
        folderNameLabel.numberOfLines = 1
        folderNameLabel.textColor = .blue
    }
    
    private func configureNumberOfItemsLabel() {
        numberOfItemsLabel.font = .systemFont(ofSize: 14)
        numberOfItemsLabel.numberOfLines = 1
        numberOfItemsLabel.textColor = .blue
    }
}
