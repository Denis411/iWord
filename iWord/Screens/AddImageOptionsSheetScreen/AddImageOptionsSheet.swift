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

typealias ClosureWithUIImage = (UIImage) -> Void

final class AddImageOptionsSheet: UIAlertController {
    private let imageResultClosure: ClosureWithUIImage

    init(with imageResultClosure: @escaping ClosureWithUIImage) {
        self.imageResultClosure = imageResultClosure
        super.init(nibName: nil, bundle: nil)
        configureActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureActions() {
        addPickPictureAction()
        addTakePictureAction()
        addCancelAction()
    }

    private func addPickPictureAction() {
        let photoImage = UIImage(systemName: "photo")

        let pickPictureFromAlbum = UIAlertAction(title: "Choose Picture", style: .default) { [unowned self] _ in
            print("Open camera")
            let personPicture = UIImage(systemName: "person")!
            self.imageResultClosure(personPicture)
        }

        pickPictureFromAlbum.setValue(photoImage, forKey: "image")

        self.addAction(pickPictureFromAlbum)
    }

    private func addTakePictureAction() {
        let cameraImage = UIImage(systemName: "camera")!

        let takePicture = UIAlertAction(title: "Take Picture", style: .default) { [unowned self] _ in
            print("Open picture picker")
            let personPicture = UIImage(systemName: "person")!
            self.imageResultClosure(personPicture)
        }

        takePicture.setValue(cameraImage, forKey: "image")

        self.addAction(takePicture)
    }

    private func addCancelAction() {
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancel)
    }
}
