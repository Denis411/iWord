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

import Foundation
import UIKit

final class LexicalUnitCreationAudioButton: UIButton {
    var buttonAction: EmptyClosure?

    init() {
        super.init(frame: .zero)
        configureSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAction(_ action: @escaping EmptyClosure) {
        self.buttonAction = action
    }

}

extension LexicalUnitCreationAudioButton {
    private func configureSelf() {
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = UIColor.white.cgColor
        self.addTarget(self, action: #selector(performAction), for: .touchUpInside)
    }

    @objc func performAction() {
        buttonAction?()
    }
}
