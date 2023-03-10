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

final class AddPictureCollectionViewCell: LexicalUnitPictureCollectionViewCell {
    override class var reusableID: String { "AddPictureCollectionViewCell" }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        setImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImage() {
        let image = UIImage(systemName: "plus")!.withRenderingMode(.alwaysTemplate)
        self.setImage(image)
    }
}
