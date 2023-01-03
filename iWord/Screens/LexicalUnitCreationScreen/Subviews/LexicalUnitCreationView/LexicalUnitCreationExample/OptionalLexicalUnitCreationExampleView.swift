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

final class OptionalLexicalUnitCreationExampleView: LabelWithOptionalSubview {
    let verticalStackView = UIStackView()
    let exampleInputView = ExampleInputView()
    let exampleView = LexicalUnitCreationExampleView()

    override init() {
        super.init()
        setUpUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setOnAddExampleActions(_ action: @escaping (Example) -> Void) {
        exampleInputView.setOnAddExampleAction(action)
    }

    func updateArrayOfExamples(_ examples: [Example]) {
        exampleView.updateArrayOfExamples(examples)
    }

    func setOnRemoveExampleAction(_ action: @escaping ClosureWithIndexPath) {
        exampleView.setOnRemoveExampleAction(action)
    }
}

extension OptionalLexicalUnitCreationExampleView {
    private func setUpUI() {
        addAllSubviews()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        verticalStackView.addArrangedSubview(exampleInputView)
        verticalStackView.addArrangedSubview(exampleView)
        addInternalView(view: verticalStackView)
    }

    private func configureAllSubviews() {
        configureVerticalStackView()
        configureSelf()
    }

    private func configureVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 10
    }

    private func configureSelf() {
        self.setTitle(text: "Examples")
    }
}
