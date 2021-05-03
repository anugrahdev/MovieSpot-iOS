//
//  ViewController.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 29/04/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewMovie: UITableView!
    private var movieServices: MovieService! = MovieService()
    private var movies: [MovieModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableViewMovie.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        let nib = UINib(nibName: "\(MovieTableViewCell.self)", bundle: nil)
        tableViewMovie.register(nib, forCellReuseIdentifier: "\(MovieTableViewCell.self)")
        tableViewMovie.delegate = self
        tableViewMovie.dataSource = self
        
        movieServices.getMoviePopular { (movieList) in
            self.movies = movieList!
        } onError: { (e: String?) in
            print(e ?? "")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMovie.dequeueReusableCell(withIdentifier: "\(MovieTableViewCell.self)", for: indexPath) as! MovieTableViewCell
        cell.tvMovie?.text = movies[indexPath.row].title
        cell.ivMovie?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300/\(movies[indexPath.row].backdropPath!)"), placeholderImage: #imageLiteral(resourceName: "placeholder_image"),completed: nil)
        cell.tvReleaseDate?.text = movies[indexPath.row].releaseDate
        cell.tvRating?.text = "\(movies[indexPath.row].voteAverage ?? 0.0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewMovie.deselectRow(at: indexPath, animated: true)
        
        onMovieClicked(movie: self.movies[indexPath.row])
    }
    
    func onMovieClicked(movie:MovieModel){
        let controller = storyboard?.instantiateViewController(identifier: "movieDetail") as! DetailMovieViewController
        controller.movieId = movie.id ?? 0
        controller.movieTitle = movie.title ?? ""
        navigationController?.pushViewController(controller, animated: true)
    }

}

