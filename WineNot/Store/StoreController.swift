//
//  ViewController.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 4/12/25.
//

import UIKit

class StoreController: UIViewController {
    
    @IBOutlet weak var productCollection: UICollectionView!
    var products: [ProductCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: UIColor(named: "color-background") ?? .green)
        productCollection.setBackgroundColor(color: .clear)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        productCollection.delegate = self
        productCollection.dataSource = self
        
        let headerNib = UINib(nibName: "StoreHeaderView", bundle: nil)
        productCollection.register(headerNib,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: StoreHeaderView.identifier)
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollection.register(nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 250)
        productCollection.collectionViewLayout = layout
        
        loadProducts()
    }
    
    func loadProducts() {
        StoreService.shared.getProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                let viewModels = products.map { product in
                    return ProductCellViewModel(
                        name: product.name,
                        price: String(format: "%.2f", product.unitPrice),
                        description: product.description,
                        imageName: product.urlImage
                    )
                }
                
                self.products.append(contentsOf: viewModels)
                DispatchQueue.main.async {
                    self.productCollection.reloadData()
                }
            case .failure(let error):
                self.showErrorMessage(message: error.localizedDescription)
            }
        }
    }
}

extension StoreController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        let indice = indexPath.row
        let product = products[indice]
        cell.updateCell(model: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfColumns - 1) * spacingBetweenCells)
        let availableWidth = collectionView.frame.width - totalSpacing
        
        let widthPerItem = availableWidth / numberOfColumns
        
        return CGSize(width: widthPerItem, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: StoreHeaderView.identifier,
                for: indexPath) as? StoreHeaderView else {
                return UICollectionReusableView()
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
}
