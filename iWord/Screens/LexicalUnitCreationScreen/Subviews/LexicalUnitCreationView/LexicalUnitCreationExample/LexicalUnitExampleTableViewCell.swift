// Data of creation: 1/1/23
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

final class LexicalUnitExampleTableViewCell: UITableViewCell {
    static let reusableID = "LexicalUnitExampleTableViewCell"
    private let originTile = UILabel()
    private let translationTitle = UILabel()
    
    func setCellData(with example: Example) {
        self.originTile.text = example.origin
        self.translationTitle.text = example.translation
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LexicalUnitExampleTableViewCell {
    private func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }
    
    private func addAllSubviews() {
        contentView.addSubview(originTile)
        contentView.addSubview(translationTitle)
    }
    
    private func addAllConstraints() {
        addOriginTitleConstraints()
        addTranslationTitleConstraints()
    }

    private func configureAllSubviews() {
        configureOriginTitle()
        configureTranslationTitle()
    }
    
    private func addOriginTitleConstraints() {
        originTile.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func addTranslationTitleConstraints() {
        translationTitle.snp.makeConstraints { make in
            make.top.equalTo(originTile.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureOriginTitle() {
        originTile.backgroundColor = .white
        originTile.numberOfLines = 0
    }
    
    private func configureTranslationTitle() {
        translationTitle.backgroundColor = .yellow
        translationTitle.numberOfLines = 0
    }
}
