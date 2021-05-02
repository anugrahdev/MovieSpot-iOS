//
//  DetailHeaderCollectionReusableView.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 02/05/21.
//

import UIKit

class DetailHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "DetailHeaderCollectionReusableView"
    
    lazy var backdropImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "jota")
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight:.medium)
        return label
    }()
    
    lazy var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight:.medium)
        return label
    
    }()
    
    lazy var runtime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight:.medium)
        return label
        
    }()
    lazy var premiere: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight:.medium)
        return label
        
    }()
    lazy var budget: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight:.medium)
        return label
        
    }()
    
    lazy var revenue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight:.medium)
        return label
        
    }()
    
    lazy var cast: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.text = "Full Cast: "
        label.font = .systemFont(ofSize: 22, weight:.medium)
        return label
    }()
    
    public func configure(with model: MovieDetailModel){
        addSubview(backdropImage)
        addSubview(title)
        addSubview(status)
        addSubview(runtime)
        addSubview(premiere)
        addSubview(budget)
        addSubview(revenue)
        addSubview(cast)
        
        backdropImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(model.backdropPath ?? "")"), placeholderImage: #imageLiteral(resourceName: "placeholder_image"),completed: nil)
        backdropImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive  = true
        backdropImage.heightAnchor.constraint(equalToConstant: 220).isActive = true
        backdropImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        backdropImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        title.text = model.originalTitle ?? ""
        title.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: 16).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        status.text = "Status: \(model.status ?? "")"
        status.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        status.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        status.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        runtime.text = "Runtime: \(model.runtime ?? 0)"
        runtime.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 16).isActive = true
        runtime.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        runtime.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        premiere.text = "Premiere: \(model.releaseDate ?? "")"
        premiere.topAnchor.constraint(equalTo: runtime.bottomAnchor, constant: 16).isActive = true
        premiere.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        premiere.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        budget.text = "Budget: \(model.budget ?? 0)"
        budget.topAnchor.constraint(equalTo: premiere.bottomAnchor, constant: 16).isActive = true
        budget.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        budget.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        revenue.text = "Revenue: \(model.revenue ?? 0)"
        revenue.topAnchor.constraint(equalTo: budget.bottomAnchor, constant: 16).isActive = true
        revenue.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        revenue.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        cast.topAnchor.constraint(equalTo: revenue.bottomAnchor, constant: 24).isActive = true
        cast.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        cast.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
    }
}
