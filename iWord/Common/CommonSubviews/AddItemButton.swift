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

typealias EmptyClosure = () -> Void

final class AddItemButton: UIButton {
    var onTapAction: EmptyClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAction(_ action: @escaping EmptyClosure) {
        self.onTapAction = action
    }

    func addConstraints() {
        self.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

extension AddItemButton {
    private func configureButton() {
        self.backgroundColor = .red
        self.layer.cornerRadius = 5
        self.addTarget(self, action: #selector(addFolderAction), for: .touchUpInside)
        let image = UIImage(systemName: "plus")
        self.setImage(image, for: .normal)
    }

    @objc func addFolderAction() {
        onTapAction?()
    }
}
