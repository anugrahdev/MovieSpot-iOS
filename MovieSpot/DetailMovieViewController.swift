//
//  DetailMovieViewController.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 30/04/21.
//

import UIKit

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var ivMovieBackdrop: UIImageView!
    @IBOutlet weak var tvMovieTitle: UILabel!
    @IBOutlet weak var tvMovieReleaseStatus: UILabel!
    @IBOutlet weak var tvMovieRuntine: UILabel!
    @IBOutlet weak var tvMoviePremiere: UILabel!
    @IBOutlet weak var tvMovieBudget: UILabel!
    @IBOutlet weak var tvMovieRevenue: UILabel!
    @IBOutlet weak var cvCast: UICollectionView!
    var movieTitle: String = ""
    var movieId: Int = 0
    private var movieServices: MovieService! = MovieService()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieTitle
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75, height: 75)
        cvCast.collectionViewLayout = layout
        let nib = UINib(nibName: "\(CastCollectionViewCell.self)", bundle: nil)
        cvCast.register(nib, forCellWithReuseIdentifier: "\(CastCollectionViewCell.self)")
        cvCast.delegate = self
        cvCast.dataSource = self
        cvCast.frame = view.bounds
        movieServices.getMovieDetail(movieId: movieId) { (detail: MovieDetailModel?) in
            if let movieDetail = detail{
                DispatchQueue.main.async {
                    self.ivMovieBackdrop.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(movieDetail.backdropPath!)"), placeholderImage: #imageLiteral(resourceName: "placeholder_image"),completed: nil)
                    self.tvMovieTitle.text = movieDetail.title ?? ""
                    self.tvMovieReleaseStatus.text = "Status: \(movieDetail.status ?? "")"
                    self.tvMovieRuntine.text = "Runtime: \(movieDetail.runtime ?? 0) minutes"
                    self.tvMoviePremiere.text = "Premiere: \(movieDetail.releaseDate ?? "")"
                    self.tvMovieBudget.text = "Budget: \(movieDetail.budget ?? 0)"
                    self.tvMovieRevenue.text = "Revenue: \(movieDetail.revenue ?? 0)"
                }
            }
        }
        
       
    }
    

}

extension DetailMovieViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("tap me \(indexPath)")
    }
}

extension DetailMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as! CastCollectionViewCell
        cell.configure(with: #imageLiteral(resourceName: "jota"))
        return cell
    }
}

extension DetailMovieViewController:    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
}
