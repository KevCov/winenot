//
//  ViewController.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 4/12/25.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var shopTitle: UILabel!
    
    var products: [ProductCellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        shopTitle.configure(text: "Bienvenido a WineNot", color: .purple, size: 24, weight: .bold)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        productCollection.delegate = self
        productCollection.dataSource = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollection.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        productCollection.collectionViewLayout = layout
        
        loadProducts()
    }
    
    func loadProducts() {
        let url = "http://localhost:8050/api/v1/products"
        APICaller.shared.getRequest(url: url) {
            (result: Result<Pageable, Error>) in
            switch result {
            case .success(let response):
                let data = response.content
                
                for product in data {
                    let cellModel = ProductCellViewModel(name: product.name, price: String(format: "%.2f", product.unitPrice), description: product.description, imageName: product.urlImage)
                    self.products.append(cellModel)
                }
                
                DispatchQueue.main.async {
                    self.productCollection.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let indice = indexPath.row
        let product = products[indice]
        print("El producto cell es: \(product.name)")
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
    
}
