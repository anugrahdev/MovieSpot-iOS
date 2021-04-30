//
//  MovieTableViewCell.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 29/04/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var tvMovie: UILabel!
    @IBOutlet weak var tvReleaseDate: UILabel!
    @IBOutlet weak var tvRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ivMovie.layer.cornerRadius = 10
        ivMovie.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
