// Data of creation: 2/1/23
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

final class ResizableTexFieldWithTitle: UIView {
    private let titleLabel = UILabel()
    private let resizableTextView = ResizableTextView(maximumHeight: 90)

    init(title: String) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addMainActionToolBarWithButton(button: ButtonName) {
        resizableTextView.addMainActionToolBarWithButton(button: button)
    }

    func makeTextViewFirstResponder() {
        resizableTextView.becomeFirstResponder()
    }

    func getTextFieldReference() -> UITextView {
        resizableTextView
    }
}

extension ResizableTexFieldWithTitle {
    private func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(resizableTextView)
    }

    private func addAllConstraints() {
        addTitleLabelConstraints()
        addResizableTextView()
    }

    private func configureAllSubviews() {
        configureTitleLabel()
    }

    private func addTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }

    private func addResizableTextView() {
        resizableTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }

    private func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20)
    }
}
