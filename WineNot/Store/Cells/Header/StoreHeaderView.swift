//
//  StoreHeaderView.swift
//  WineNot
//
//  Created by Kevin Cordova Aquije on 13/12/25.
//

import UIKit

class StoreHeaderView: UICollectionReusableView {
    static let identifier = "StoreHeaderView"
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundColor(color: UIColor(named: "color-background") ?? .green)
        headerTitle.configure(text: "Bienvenido a WineNot", color: UIColor(named: "text-primary") ?? .purple, size: 24, weight: .bold)
        bannerImage.setContenMode()
        bannerImage.setRoundCorners(radius: 10)
        bannerImage.setImageName(name: "banner")
    }
    
}
