// Data of creation: 3/1/23
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

class LabelWithOptionalSubview: UIStackView {
    private let headerHorizontalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let switchView = UISwitch()
    private(set) var internalView: UIView?

    init() {
        super.init(frame: .zero)
        setUpUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(text: String) {
        self.titleLabel.text = text
    }

    func addInternalView(view: UIView) {
        self.internalView = view
    }

    @objc private func changeVisibility(sender: UISwitch) {
        guard let internalView = internalView else {
            return
        }

        if sender.isOn {
            self.addArrangedSubview(internalView)
        } else {
            internalView.removeFromSuperview()
        }
    }
}

extension LabelWithOptionalSubview {
    private func setUpUI() {
        addAllSubviews()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        headerHorizontalStackView.addArrangedSubview(titleLabel)
        headerHorizontalStackView.addArrangedSubview(switchView)
        self.addArrangedSubview(headerHorizontalStackView)
    }

    private func configureAllSubviews() {
        configureSelf()
        configureHeaderHorizontalStackView()
        configureSwitchView()
    }

// MARK: - Configuration -
    private func configureSelf() {
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = 10
    }

    private func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 20)
    }

    private func configureSwitchView() {
        switchView.isOn = false
        switchView.addTarget(self, action: #selector(changeVisibility), for: .touchUpInside)
    }

    private func configureHeaderHorizontalStackView() {
        headerHorizontalStackView.axis = .horizontal
        headerHorizontalStackView.distribution = .fill
        headerHorizontalStackView.spacing = 10
    }
}
