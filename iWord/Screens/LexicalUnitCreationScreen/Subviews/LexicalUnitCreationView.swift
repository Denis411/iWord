// Data of creation: 27/12/22
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

final class LexicalUnitCreationView: CommonView {
    let resizableTextView = ResizableTextView(maximumHeight: 90)

    override func setUpUI() {
        addAllSubviews()
        setAllConstraints()
        configureAllSubviews()
    }
}

extension LexicalUnitCreationView {
    private func addAllSubviews() {
        self.addSubview(resizableTextView)
    }

    private func setAllConstraints() {
        resizableTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(100)
        }
    }

    private func configureAllSubviews() {
        configureSelf()
    }

    private func configureSelf() {
        self.backgroundColor = .gray
    }
}
