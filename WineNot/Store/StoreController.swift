//
//  ViewController.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 4/12/25.
//

import UIKit

class StoreController: UIViewController {
    
    @IBOutlet weak var productCollection: UICollectionView!
    var products: [ProductCellViewModel] = [
        ProductCellViewModel(
            name: "Trapiche Fond de Cave Cabernet Sauvignon 750ml 2020",
            price: "89.50",
            description: "Cabernet Sauvignon intenso, frutos negros, especias y roble. Un vino con gran estructura y elegancia.",
            imageName: "concha-toro-marques-cabernet"
        ),
        ProductCellViewModel(
            name: "Luigi Bosca Gala 1 Malbec 750ml 2019",
            price: "210.00",
            description: "Malbec de parcela única, frutos rojos, flores y minerales. Un vino complejo y elegante con gran potencial de guarda.",
            imageName: "concha-todo-melchor-cabernet"
        ),
        ProductCellViewModel(
            name: "Catena Zapata D.V. Catena Cabernet-Malbec 750ml 2019",
            price: "399.00",
            description: "Blend equilibrado, frutos negros, especias y notas florales. Un vino complejo y elegante.",
            imageName: "fond-cave-reserva-cabernet"
        ),
        ProductCellViewModel(
            name: "Concha y Toro Amelia Chardonnay 750ml 2021",
            price: "45.00",
            description: "Chardonnay elegante, cítricos, minerales y roble francés. Un vino fresco y complejo.",
            imageName: "concha-toro-marques-cabernet"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: UIColor(named: "color-background") ?? .green)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        productCollection.setDetegate(vc: self)
        productCollection.setBackgroundColor(color: .clear)
        productCollection.setHeader(uinibName: "StoreHeaderView", cellIdentifier: StoreHeaderView.identifier)
        productCollection.setCell(uinibName: "ProductCollectionViewCell", cellIdentifier: ProductCollectionViewCell.identifier)
        productCollection.collectionViewLayout = createCompositionalLayout()
        
        //loadProducts()
    }
    
    private func loadProducts() {
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
            let productCart = ProductCartCellModel(name: product.name, unitPrice: Double(product.price) ?? 0.0, urlImage: product.imageName, quantity: 1)
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
