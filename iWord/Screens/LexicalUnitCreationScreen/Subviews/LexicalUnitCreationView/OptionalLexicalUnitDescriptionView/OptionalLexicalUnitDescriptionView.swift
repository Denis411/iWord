// Data of creation: 4/1/23
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

final class OptionalLexicalUnitDescriptionView: LabelWithOptionalSubview {
    private let inputTextView = ResizableTextView(maximumHeight: 90)
    
    override init() {
        super.init()
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTextFieldReference() -> UITextView {
        inputTextView
    }
    
    func makeTextViewFirstResponder() {
        inputTextView.becomeFirstResponder()
    }
}

extension OptionalLexicalUnitDescriptionView {
    private func setUpUI() {
        configureAllSubviews()
    }
    
    private func configureAllSubviews() {
        configureSelf()
        configureInputTextView()
    }
    
    private func configureSelf() {
        setTitle(text: "Description")
        addInternalView(view: inputTextView)
    }
    
    private func configureInputTextView() {
        inputTextView.addMainActionToolBarWithButton(button: "Next")
    }
}
