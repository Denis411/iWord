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
        self.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 0.0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
