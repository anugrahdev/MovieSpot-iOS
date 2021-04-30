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
    var movieTitle: String = ""
    var movieId: Int = 0
    private var movieServices: MovieService! = MovieService()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieTitle
        movieServices.getMovieDetail(movieId: movieId) { (detail: MovieDetailModel?) in
            if let movieDetail = detail{
                DispatchQueue.main.async {
                    self.ivMovieBackdrop?.load(urlString: "https://image.tmdb.org/t/p/w500/\(movieDetail.backdropPath!)")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
