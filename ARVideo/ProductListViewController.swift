//
//  ProductListViewController.swift
//  ARVideo
//
//  Created by Karthick Selvaraj on 28/01/18.
//  Copyright © 2018 Mallow technologies. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    let productList = ["AirPods", "HomPod", "iMac Pro", "iPad Pro", "iPhone 7 & 7+", "iPhone 8 & 8+", "iPhone X", "MacBook Pro", "Watch Series 3"]

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Products List"
        tableView.tableFooterView = UIView()
    }
    
}


extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = productList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedProduct = productList[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        viewController?.selectedProductName = selectedProduct
        navigationController?.pushViewController(viewController!, animated: true)
    }
    
}
