//
//  MovieService.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 29/04/21.
//

import Foundation
import Alamofire

class MovieService {
    func getMoviePopular(onSuccess: @escaping ([MovieModel]?)->()){
        guard let url = URL(string:
                                "https://api.themoviedb.org/3/movie/popular?api_key=\(Config.MovieDB.apiKey)")
        else{
            onSuccess(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            guard let data = data, error == nil else{
                print("gagal")
                onSuccess(nil)
                return
            }
            
            let popularMovieResponse = try? JSONDecoder().decode(MovieResponseModel.self, from: data)
            if let response = popularMovieResponse{
                onSuccess(response.results)
            }else{
                onSuccess(nil)
            }
            
        }.resume()
    }
    
    func getMovieDetail(movieId:Int, onSuccess: @escaping (MovieDetailModel?)->()){
        guard let url = URL(string:
                                "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(Config.MovieDB.apiKey)")
        else{
            onSuccess(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            guard let data = data, error == nil else{
                print("gagal")
                onSuccess(nil)
                return
            }
            
            let detailMovieResponse = try? JSONDecoder().decode(MovieDetailModel.self, from: data)
            if let response = detailMovieResponse{
                onSuccess(response)
            }else{
                onSuccess(nil)
            }
            
        }.resume()
    }
    
    func getCredits(movieId:Int, onSuccess: @escaping ([CastModel]?)->()){
        guard let url = URL(string:
                                "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(Config.MovieDB.apiKey)")
        else{
            onSuccess(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            guard let data = data, error == nil else{
                print("gagal")
                onSuccess(nil)
                return
            }
            
            let creditsResponse = try? JSONDecoder().decode(CreditsModel.self, from: data)
            if let response = creditsResponse{
                onSuccess(response.cast)
            }else{
                onSuccess(nil)
            }
            
        }.resume()
    }
  
}
