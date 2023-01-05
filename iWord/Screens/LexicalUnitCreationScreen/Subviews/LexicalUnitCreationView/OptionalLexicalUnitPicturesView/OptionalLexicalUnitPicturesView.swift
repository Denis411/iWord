// Data of creation: 5/1/23
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

final class OptionalLexicalUnitPicturesView: LabelWithOptionalSubview {
    private let pictureCollectionView = LexicalUnitPicturesCollectionView()

    override init() {
        super.init()
        configureAllViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImages(_ images: [UIImage]) {
        pictureCollectionView.setImages(images)
    }

    func setOnRemoveImageActionAtIndexPath(_ action: @escaping ClosureWithIndexPath) {
        pictureCollectionView.setOnRemoveImageActionAtIndexPath(action)
    }

    func setOnAddNewPictureAction(_ action: @escaping EmptyClosure) {
        pictureCollectionView.setOnAddNewPictureAction(action)
    }
}

extension OptionalLexicalUnitPicturesView {
    private func configureAllViews() {
        configureSelf()
    }

    private func configureSelf() {
        self.setTitle(text: "Pictures")
        self.addInternalView(view: pictureCollectionView)
    }
}
