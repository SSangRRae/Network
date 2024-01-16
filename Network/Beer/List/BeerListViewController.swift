//
//  BeerListViewController.swift
//  Network
//
//  Created by SangRae Kim on 1/16/24.
//

import UIKit

class BeerListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var list: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        BeerManager(url: "https://api.punkapi.com/v2/beers").requestToListServer { beerList in
            self.list = beerList
            self.tableView.reloadData()
        }
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: "BeerListTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "BeerListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListTableViewCell", for: indexPath) as! BeerListTableViewCell
        let item = list[indexPath.row]
        
        cell.configureCell(item)
        
        return cell
    }
}
