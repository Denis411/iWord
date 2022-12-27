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

final class LexicalUnitCreationView: CommonView {
    private let resizableTextView = ResizableTextView(maximumHeight: 90)
    private let audioButtonsStackView = UIStackView()
    private let recordAudioButton = LexicalUnitCreationAudioButton()
    private let playAudioButton = LexicalUnitCreationAudioButton()

    override func setUpUI() {
        addAllSubviews()
        setAllConstraints()
        configureAllSubviews()
    }

    func setActionForRecordAudioButton(_ action: @escaping EmptyClosure) {
        recordAudioButton.setAction(action)
    }

    func setActionForPlayAudioButton(_ action: @escaping EmptyClosure) {
        playAudioButton.setAction(action)
    }
}

extension LexicalUnitCreationView {
    private func addAllSubviews() {
        self.addSubview(resizableTextView)
        self.addSubview(audioButtonsStackView)
        self.audioButtonsStackView.addArrangedSubview(recordAudioButton)
        self.audioButtonsStackView.addArrangedSubview(playAudioButton)
    }

    private func setAllConstraints() {
        setResizableTextViewConstraints()
        setAudioButtonsStackViewConstraints()
    }

    private func setResizableTextViewConstraints() {
        resizableTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(100)
        }
    }

    private func setAudioButtonsStackViewConstraints() {
        audioButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(resizableTextView.snp.bottom).offset(20)
            make.left.equalTo(resizableTextView.snp.left)
            make.right.equalTo(resizableTextView.snp.right)
            make.height.equalTo(50)
        }
    }

    private func configureAllSubviews() {
        configureSelf()
        configureAudioButtonsStackView()
        configureRecordAudioButton()
        configurePlayAudioButton()
    }

    private func configureAudioButtonsStackView() {
        audioButtonsStackView.axis = .horizontal
        audioButtonsStackView.spacing = 20
        audioButtonsStackView.distribution = .fillEqually
    }

    private func configureRecordAudioButton() {
        let image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        recordAudioButton.imageView?.tintColor = .red
        recordAudioButton.setImage(image, for: .normal)
    }

    private func configurePlayAudioButton() {
        let image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate)
        playAudioButton.imageView?.tintColor = .green
        playAudioButton.setImage(image, for: .normal)
    }

    private func configureSelf() {
        self.backgroundColor = .gray
    }
}