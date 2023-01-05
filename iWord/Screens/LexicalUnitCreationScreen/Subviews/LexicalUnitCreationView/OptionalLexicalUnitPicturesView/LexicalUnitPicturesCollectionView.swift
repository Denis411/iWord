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

class LexicalUnitPicturesCollectionView: UICollectionView {
    private var images: [UIImage] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    private let addPictureCell = AddPictureCollectionViewCell()
    private var onRemoveImageAction: ClosureWithIndexPath?
    private var heightConstraint: NSLayoutConstraint?
    private var onAddNewPictureAction: EmptyClosure?

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        setSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        heightConstraint?.constant = contentSize.height
    }

    func setImages(_ image: [UIImage]) {
        self.images = image
    }

    func setOnRemoveImageActionAtIndexPath(_ action: @escaping ClosureWithIndexPath) {
        self.onRemoveImageAction = action
    }

    func setOnAddNewPictureAction(_ action: @escaping EmptyClosure) {
        self.onAddNewPictureAction = action
    }
}

extension LexicalUnitPicturesCollectionView {
    private func setSelf() {
        dataSource = self
        delegate = self
        register(LexicalUnitPictureCollectionViewCell.self,
                 forCellWithReuseIdentifier: LexicalUnitPictureCollectionViewCell.reusableID)
        register(AddPictureCollectionViewCell.self, forCellWithReuseIdentifier: AddPictureCollectionViewCell.reusableID)
        setUpHeightConstraint()
    }

    private func setUpHeightConstraint() {
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
}

extension LexicalUnitPicturesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//      the last cell is AddPictureCollectionViewCell acting as a button
        images.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row <= (images.count - 1) {
            return dequeuePictureCell(collectionView: collectionView, indexPath: indexPath)
        } else {
            return dequeueAppPictureCell(collectionView: collectionView, indexPath: indexPath)
        }
    }

    private func dequeuePictureCell(collectionView: UICollectionView, indexPath: IndexPath) -> LexicalUnitPictureCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LexicalUnitPictureCollectionViewCell.reusableID, for: indexPath) as! LexicalUnitPictureCollectionViewCell
        cell.setImage(images[indexPath.row])
        return cell
    }

    private func dequeueAppPictureCell(collectionView: UICollectionView, indexPath: IndexPath) -> AddPictureCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPictureCollectionViewCell.reusableID, for: indexPath) as! AddPictureCollectionViewCell
        return cell
    }
}


extension LexicalUnitPicturesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count {
            onAddNewPictureAction?()
        }
    }
}

