//
//  BeerViewController.swift
//  Network
//
//  Created by SangRae Kim on 1/16/24.
//

import UIKit
import Kingfisher

class BeerViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var randomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configure()
        recommandBeer()
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        recommandBeer()
    }
}

extension BeerViewController {
    func configureNavigation() {
        navigationItem.title = "Beer"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "맥주 리스트", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func rightBarButtonClicked() {
        let sb = UIStoryboard(name: "BeerList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BeerListViewController") as! BeerListViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BeerViewController {
    func configure() {
        titleLabel.text = "오늘은 이 맥주를 추천합니다!"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .center
        
        randomButton.setTitle("다른 맥주 추천받기", for: .normal)
        randomButton.setImage(UIImage(systemName: "plus"), for: .normal)
        randomButton.tintColor = .orange
    }
    
    func recommandBeer() {
        BeerManager().requestToServer { beer in
            if let image = beer.image_url {
                let url = URL(string: image)
                self.beerImageView.kf.setImage(with: url)
            } else {
                self.beerImageView.image = UIImage(systemName: "xmark")
                self.beerImageView.tintColor = .black
            }
            self.nameLabel.text = beer.name
            self.descriptionLabel.text = beer.description
        }
    }
}
