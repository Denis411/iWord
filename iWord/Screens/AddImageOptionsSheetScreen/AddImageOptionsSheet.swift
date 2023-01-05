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

final class AddImageOptionsSheet: UIAlertController {

    init() {
        super.init(nibName: nil, bundle: nil)
        configureActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureActions() {
        let pickPictureFromAlbum = UIAlertAction(title: "Choose Picture", style: .default) { _ in
            print("Open camera")
        }

        let takePicture = UIAlertAction(title: "Take Picture", style: .default) { _ in
            print("Open picture picker")
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        self.addAction(pickPictureFromAlbum)
        self.addAction(takePicture)
        self.addAction(cancel)
    }
}
