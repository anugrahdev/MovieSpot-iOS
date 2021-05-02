//
//  CastCollectionViewCell.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 01/05/21.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivCast: UIImageView!
    
    static let identifier = "CastCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model:CastModel) {
        ivCast?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300/\(model.profilePath ?? "")"), placeholderImage: #imageLiteral(resourceName: "placeholder_image"),completed: nil)
    }
    

}
