import UIKit

extension UITableView {
    func setDelegate(vc: UITableViewDelegate&UITableViewDataSource) {
        self.delegate = vc
        self.dataSource = vc
    }
    
    func setCell(uinibName: String, cellIdentifier: String) {
        self.register(UINib(nibName: uinibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}
