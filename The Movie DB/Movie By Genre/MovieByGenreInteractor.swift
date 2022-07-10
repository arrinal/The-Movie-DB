//
//  MovieByGenreInteractor.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation
import SwiftyJSON

protocol MovieByGenreInteractorProtocol {
    var presenter: MovieByGenrePresenterOutput! { get set }
    var movies: [Movie] { get set }
    
    func fetchMovie(pagination: Bool, for genreID: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func movieTotal() -> Int
    func movieName(at indexPath: IndexPath) -> String
    func movieDetail(at indexPath: IndexPath)
    func addData(data: [Movie])
    func getPaginatingStatus() -> Bool
    
}

class MovieByGenreInteractor: MovieByGenreInteractorProtocol {
    
    var presenter: MovieByGenrePresenterOutput!
    var movies = [Movie]()
    
    var isPaginating = false
    var currentPage = 1
    var totalPage = Int()
    
    func fetchMovie(pagination: Bool, for genreID: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard totalPage == 0 || currentPage <= totalPage else { return }
        
        
        if pagination {
            isPaginating = true
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: { [self] in
            
            if isPaginating == false {
                let source = "https://api.themoviedb.org/3/discover/movie?api_key=dbeb6ccadcf4200106585226109d1d61&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genreID)&with_watch_monetization_types=flatrate"
                let url = URL(string: source)!
                let session = URLSession(configuration: .default)
        
                session.dataTask(with: url) { data, _, error in
        
                    if error != nil {
                        print((error?.localizedDescription)!)
                        return
        
                    }

                    if let movieDB = try? JSON(data: data!) {
        
                        let genre = movieDB["results"]
        
        
                        for result in genre {
                            let id = result.1["id"].intValue
                            let movieTitle = result.1["original_title"].stringValue
                            let totalPage = result.1["total_pages"].intValue
        
                            DispatchQueue.main.async {
                                self.movies += [Movie(id: id, original_title: movieTitle)]
                                self.totalPage = totalPage
                            }
                            
                            
                        }
                    }
                    
                    DispatchQueue.main.async { [self] in
                        completion(.success(movies))
                    }
        
                }.resume()
            } else {
                
                currentPage += 1
                let source = "https://api.themoviedb.org/3/discover/movie?api_key=dbeb6ccadcf4200106585226109d1d61&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(currentPage)&with_genres=\(genreID)&with_watch_monetization_types=flatrate"
                let url = URL(string: source)!
                let session = URLSession(configuration: .default)
        
                session.dataTask(with: url) { data, _, error in
        
                    if error != nil {
                        print((error?.localizedDescription)!)
                        return
        
                    }

                    if let movieDB = try? JSON(data: data!) {
        
                        let genre = movieDB["results"]
        
        
                        for result in genre {
                            let id = result.1["id"].intValue
                            let movieTitle = result.1["original_title"].stringValue
        
                            DispatchQueue.main.async {
                                self.movies += [Movie(id: id, original_title: movieTitle)]
                            }
                            
                            
                        }
                    }
                    
                    DispatchQueue.main.async { [self] in
                        completion(.success(movies))
                    }
        
                }.resume()
            }
                    
            if pagination {
                self.isPaginating = false
            }
        })
    }
    
    func movieTotal() -> Int {
        movies.count
    }
    
    func movieName(at indexPath: IndexPath) -> String {
        movies[indexPath.row].original_title
    }
    
    func movieDetail(at indexPath: IndexPath) {
        let movieID = movies[indexPath.row].id
        presenter.pushToMovieDetail(id: movieID)
    }
    
    func addData(data: [Movie]) {
        self.movies.append(contentsOf: data)
    }
    
    func getPaginatingStatus() -> Bool {
        isPaginating
    }
    
}
