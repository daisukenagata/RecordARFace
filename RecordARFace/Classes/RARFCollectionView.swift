//
//  RARFCollectionView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
public final class RARFCollectionView: UIView {

    public lazy var aObject: RARFObject = {
        let aObject = RARFObject()
        return aObject
    }()
    
    let vm = RARFCollectionViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-5,
                                 height: UIScreen.main.bounds.height/2-UINavigationController.init().navigationBar.frame.height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RARFCollectionCell().identifier, forCellWithReuseIdentifier: "RARFCollectionCell")
        collectionView.register(RARFCollectionCell.self, forCellWithReuseIdentifier: "RARFCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = vm
        return collectionView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(collectionView)
        addSubview(scrollView)
        return scrollView
    }()

    private var index = 0

    public init() {
        super.init(frame: .zero)

        aObject.arscnView.isHidden = true

        self.frame = UIScreen.main.bounds
        scrollView.frame = self.bounds
        collectionView.frame = self.bounds
        aObject.arscnView.frame = self.bounds
        addSubview(collectionView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func viewHidden() {
        aObject.arscnView.removeFromSuperview()
        collectionView.isHidden = false
    }

    public func viewEyesTracking() {
        collectionView.isHidden = true
        aObject.arscnView.removeFromSuperview()
        aObject = RARFObject()
        addSubview(aObject.arscnView)
        aObject.eyeTracking(color: vm.imagesRows[index].imageSet)
    }
}

// MARK: UICollectionViewDelegate
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.isHidden = true
        aObject.arscnView.removeFromSuperview()
        aObject = RARFObject()
        aObject.texturedFace(color: vm.imagesRows[indexPath.row].imageSet)
        index = indexPath.row
        addSubview(aObject.arscnView)
        aObject.tableView.isHidden = true
    }
}
