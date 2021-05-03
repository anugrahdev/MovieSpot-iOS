//
//  MovieService.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 29/04/21.
//

import Foundation
import Alamofire

class MovieService {
    func getMoviePopular(onSuccess: @escaping ([MovieModel]?)->(), onError: @escaping (String?)->()){
        let parameters = ["api_key":"\(Config.MovieDB.apiKey)"]
        let base_url = Config.MovieDB.base_url
        let request = Alamofire.request("\(base_url)movie/popular", method: .get, parameters: parameters)
        request
            .validate(statusCode: 200..<300)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let result = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                    onSuccess(result.results)
                }catch{
                    onError(error.localizedDescription)
                }
            }
    }
    
    func getMovieDetail(movieId:Int, onSuccess: @escaping (MovieDetailModel?)->(), onError: @escaping (String?)->()){
        let parameters = ["api_key":"\(Config.MovieDB.apiKey)"]
        let base_url = Config.MovieDB.base_url
        let request = Alamofire.request("\(base_url)movie/\(movieId)", method: .get, parameters: parameters)
        request
            .validate(statusCode: 200..<300)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let result = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                    onSuccess(result)
                }catch{
                    onError(error.localizedDescription)
                }
            }
    }
    
    func getMovieCredits(movieId:Int, onSuccess: @escaping ([CastModel]?)->(), onError: @escaping (String?)->()){
        let parameters = ["api_key":"\(Config.MovieDB.apiKey)"]
        let base_url = Config.MovieDB.base_url
        let request = Alamofire.request("\(base_url)movie/\(movieId)/credits", method: .get, parameters: parameters)
        request
            .validate(statusCode: 200..<300)
            .response { (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let result = try JSONDecoder().decode(CreditsModel.self, from: data)
                    onSuccess(result.cast)
                }catch{
                    onError(error.localizedDescription)
                }
            }
    }
}
