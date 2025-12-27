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
        view.setBackgroundColor(color: .appBackground)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        productCollection.setDetegate(vc: self)
        productCollection.setBackgroundColor(color: .clear)
        productCollection.setHeader(uinibName: "StoreHeaderView", cellIdentifier: StoreHeaderView.identifier)
        productCollection.setCell(uinibName: "ProductCollectionViewCell", cellIdentifier: ProductCollectionViewCell.identifier)
        productCollection.collectionViewLayout = createCompositionalLayout()
        
        loadProducts()
    }
    
    private func loadProducts() {
        StoreService.shared.getProducts { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let viewModels):
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
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(390)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
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
        
        cell.onAddButtonTapped = {
            let productCart = ProductCartCellModel(id: product.id , name: product.name, unitPrice: Double(product.price) ?? 0.0, urlImage: product.imageName, quantity: 1)
            CartManager.shared.add(product: productCart)
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        
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
