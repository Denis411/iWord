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

final class ExampleInputView: UIStackView {
    private let exampleOriginTextField = ResizableTextView(maximumHeight: 90)
    private let exampleTranslationTextField = ResizableTextView(maximumHeight: 90)
    private var onAddExampleAction: ((Example) -> Void)?

    init() {
        super.init(frame: .zero)
        setUpUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setOnAddExampleAction(_ action: @escaping (Example) -> Void) {
        self.onAddExampleAction = action
    }
}

extension ExampleInputView {
    private func setUpUI() {
        addAllSubviews()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        self.addArrangedSubview(exampleOriginTextField)
        self.addArrangedSubview(exampleTranslationTextField)
    }

    private func configureAllSubviews() {
        configureSelf()
        configureExampleOriginTextField()
        configureExampleTranslationTextField()
    }

    private func configureSelf() {
        self.axis = .vertical
        self.distribution = .fill
        self.spacing = 10
    }

    private func configureExampleOriginTextField() {
        exampleOriginTextField.addMainActionToolBarWithButton(button: "To translation")
    }

    private func configureExampleTranslationTextField() {
        exampleTranslationTextField.addMainActionToolBarWithButton(button: "Add example")
    }
}

extension ExampleInputView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        switch sender {
        case exampleOriginTextField:
            exampleTranslationTextField.becomeFirstResponder()
        case exampleTranslationTextField:
            addExample()
        default:
            return
        }
    }

    private func addExample() {
        let example = Example(
            origin: exampleOriginTextField.text,
            translation: exampleTranslationTextField.text
        )

        onAddExampleAction?(example)

        exampleOriginTextField.text = ""
        exampleTranslationTextField.text = ""
    }
}
