//
//  MovieDetailInteractor.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation
import SwiftyJSON

protocol MovieDetailInteractorProtocol {
    var presenter: MovieDetailPresenterOutput! { get set }
    var movieDetailVM: MovieDetail { get set }
    var movieReviewVM: [MovieReview] { get set }
    var trailerKey: YoutubeTrailer { get set }
    
    func fetchMovieDetail(for movieID: Int)
    func fetchReview(for movieID: Int)
    func fetchTrailer(for movieID: Int)
    func reviewTotal() -> Int
    func getMovieReviewVM() -> [MovieReview]
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var presenter: MovieDetailPresenterOutput!
    
    var movieDetailVM = MovieDetail(id: 0, title: "", genre: [], overview: "", releaseDate: "")
    var movieReviewVM = [MovieReview]()
    var trailerKey = YoutubeTrailer(trailerKey: "")
    
    func fetchMovieDetail(for movieID: Int) {
        let source = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=dbeb6ccadcf4200106585226109d1d61&language=en-US"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
                
            }
            
            if let movieDB = try? JSON(data: data!) {
                
                let id = movieDB["id"].intValue
                let title = movieDB["original_title"].stringValue
                var genres = [String]()
                for genre in movieDB["genres"] {
                    genres += [genre.1["name"].stringValue]
                }
                let overview = movieDB["overview"].stringValue
                let releaseDate = movieDB["release_date"].stringValue
                
                    DispatchQueue.main.async {
                        self.movieDetailVM = MovieDetail(id: id, title: title, genre: genres, overview: overview, releaseDate: releaseDate)
                    }
            }
            
            DispatchQueue.main.async { [self] in
                presenter.updateData(vm: movieDetailVM)
            }
            
        }.resume()
    }
    
    func fetchReview(for movieID: Int) {
        let source = "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=dbeb6ccadcf4200106585226109d1d61&language=en-US"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
                
            }
            
            if let movieDB = try? JSON(data: data!) {
                
                for result in movieDB["results"] {
                    let author = result.1["author"].stringValue
                    let rating = result.1["author_details"]["rating"].intValue
                    let review = result.1["content"].stringValue
                    
                    DispatchQueue.main.async {
                        self.movieReviewVM += [MovieReview(author: author, rating: rating, review: review)]
                    }
                }
            }
            
            DispatchQueue.main.async { [self] in
                presenter.updateDataReview()
            }
            
        }.resume()
    }
    
    func fetchTrailer(for movieID: Int) {
        let source = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=dbeb6ccadcf4200106585226109d1d61&language=en-US"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
                
            }
            
            if let movieDB = try? JSON(data: data!) {
                
                for result in movieDB["results"] {
                    let trailer = result.1["type"].stringValue
                    if trailer == "Trailer" {
                        let trailerKey = result.1["key"].stringValue
                        DispatchQueue.main.async {
                            self.trailerKey = YoutubeTrailer(trailerKey: trailerKey)
                        }
                        break
                    }
                }
            }
            
            DispatchQueue.main.async { [self] in
                presenter.updateDataReview()
                presenter.updateYoutubeTrailer(key: trailerKey)
            }
            
        }.resume()
    }
    
    func reviewTotal() -> Int {
        movieReviewVM.count
    }
    
    func getMovieReviewVM() -> [MovieReview] {
        movieReviewVM
    }
    
}
