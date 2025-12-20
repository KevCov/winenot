//
//  Extension+UICollectionView.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 20/12/25.
//
import UIKit

extension UICollectionView {
    
    func setDetegate(vc: UICollectionViewDelegate&UICollectionViewDataSource) {
        self.delegate = vc
        self.dataSource = vc
    }
    
    func setCell(uinibName: String, cellIdentifier: String) {
        self.register(UINib(nibName: uinibName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setHeader(uinibName: String, cellIdentifier: String) {
        self.register(UINib(nibName: uinibName, bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellIdentifier)
    }
}
