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

// Height constraint should no be set from outside
final class ResizableTextView: UITextView {
    private let maximumHeight: CGFloat
    private var heightConstraint: NSLayoutConstraint?
    override var contentSize: CGSize {
        didSet {
            reactionToContentSizeChanging()
        }
    }

    init(maximumHeight: CGFloat) {
        self.maximumHeight = maximumHeight
        super.init(frame: .zero, textContainer: nil)
        configureSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 0.0)
    }

    private func reactionToContentSizeChanging() {
        if contentSize.height >= maximumHeight {
            return
        }

        heightConstraint?.isActive = false

        heightConstraint?.constant = contentSize.height
        heightConstraint?.priority = UILayoutPriority(999)

        heightConstraint?.isActive = true
        self.setNeedsLayout()
    }
}


// MARK: - UIResponder chain settings for UITextView -
typealias ButtonName = String

@objc protocol UITextViewToolBarButtonAction {
    /// Catches actions send from UITextView via UIResponder chain
    /// - Parameter sender: a UITextView from which the message is sent
    @objc func setOnToolBarButtonAction(sender: UITextView)
}

extension UITextView {
    /// Adds a UIBarButton to keyboard with specified name
    ///  action should be specified in a method of the protocol UITextViewToolBarButtonAction
    /// - Parameter name: name of a UIBarButton above a keyboard
    func addMainActionToolBarWithButton(button name: ButtonName) {
        let toolBarFrame = CGRect(x: 0, y: 0, width: 200, height: 50)
        let toolBar = UIToolbar(frame: toolBarFrame)
        let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
        let barButtonItem = UIBarButtonItem(title: name, style: .done, target: nil, action: #selector(performDoneButtonAction))
        toolBar.items = [spacer, barButtonItem]
        self.inputAccessoryView = toolBar
    }

//    TODO: - rename done
    @objc private func performDoneButtonAction() {
        UIApplication.shared.sendAction(
            #selector(UITextViewToolBarButtonAction.setOnToolBarButtonAction),
            to: nil,
            from: self,
            for: nil)
    }
}
