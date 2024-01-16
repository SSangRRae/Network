//
//  BeerListTableViewCell.swift
//  Network
//
//  Created by SangRae Kim on 1/17/24.
//

import UIKit
import Kingfisher

class BeerListTableViewCell: UITableViewCell {

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonDesignCell()
    }
}

extension BeerListTableViewCell {
    func commonDesignCell() {
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .boldSystemFont(ofSize: 18)
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
    }
    
    func configureCell(_ item: Beer) {
        if let image = item.image_url {
            let url = URL(string: image)
            beerImageView.kf.setImage(with: url)
        } else {
            beerImageView.image = UIImage(systemName: "xmark")
            beerImageView.tintColor = .black
        }
        nameLabel.text = "\(item.id). \(item.name)"
        descriptionLabel.text = item.description
    }
}
