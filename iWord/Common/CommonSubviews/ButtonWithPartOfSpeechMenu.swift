// Data of creation: 30/12/22
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

final class ButtonWithPartOfSpeechMenu: UIButton {
    private var onChoosePartOfSpeechAction: ((PartOfSpeech) -> Void)?

    init() {
        super.init(frame: .zero)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setOnChoosePartOfSpeechAction(_ action: @escaping (PartOfSpeech) -> Void) {
        onChoosePartOfSpeechAction = action
    }

    private func setUpUI() {
        let actions = createActionsForChangePartOfSpeechMenu()
        self.menu = UIMenu(title: "Parts of speech", options: .displayInline, children: actions)
        self.showsMenuAsPrimaryAction = true
    }

    private func createActionsForChangePartOfSpeechMenu() -> [UIAction] {
        let actions = PartOfSpeech.allCases.map { partOfSpeech in
            UIAction(title: partOfSpeech.rawValue.capitalized) { [unowned self] _ in
                self.onChoosePartOfSpeechAction?(partOfSpeech)
            }
        }

        return actions
    }
}
