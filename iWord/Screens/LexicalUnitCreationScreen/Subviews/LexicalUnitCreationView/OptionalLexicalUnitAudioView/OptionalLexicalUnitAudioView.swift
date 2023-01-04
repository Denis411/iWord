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

final class OptionalLexicalUnitAudioView: LabelWithOptionalSubview {
    private let horizontalButtonStack = UIStackView()
    private let recordButton = LexicalUnitCreationAudioButton()
    private let playButton = LexicalUnitCreationAudioButton()

    func setActionForRecordAudioButton(_ action: @escaping EmptyClosure) {
        recordButton.setAction(action)
    }

    func setActionForPlayAudioButton(_ action: @escaping EmptyClosure) {
        playButton.setAction(action)
    }

    override init() {
        super.init()
        setUpUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OptionalLexicalUnitAudioView {
    private func setUpUI() {
        addAllSubviews()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        horizontalButtonStack.addArrangedSubview(recordButton)
        horizontalButtonStack.addArrangedSubview(playButton)
        self.addInternalView(view: horizontalButtonStack)
    }

    private func configureAllSubviews() {
        configureSelf()
        configureHorizontalButtonStack()
        configureRecordButton()
        configurePlayButton()
    }

    private func configureSelf() {
        self.setTitle(text: "Human voice audio")
    }

    private func configureHorizontalButtonStack() {
        horizontalButtonStack.axis = .horizontal
        horizontalButtonStack.distribution = .fillEqually
        horizontalButtonStack.spacing = 25
    }

    private func configureRecordButton() {
        let recordImage = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        recordButton.imageView?.tintColor = .red
        recordButton.setImage(recordImage, for: .normal)
    }

    private func configurePlayButton() {
        let playImage = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate)
        playButton.imageView?.tintColor = .green
        playButton.setImage(playImage, for: .normal)
    }
}
