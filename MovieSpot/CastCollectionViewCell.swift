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
    
    public func configure(with image:UIImage) {
        ivCast.image = image
    }
    

}
