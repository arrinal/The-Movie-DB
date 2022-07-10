//
//  Interactor.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 05/07/22.
//

import Foundation
import SwiftyJSON

protocol MovieInteractorProtocol {
    var presenter: MoviePresenterOutput!  { get set }
    var movieGenre: [MovieGenre]  { get set }
    func getGenre()
    func genreTotal() -> Int
    func genreName(at indexPath: IndexPath) -> String
    func discoverMovie(at indexPath: IndexPath)
}

class MovieInteractor: MovieInteractorProtocol {
    
    var presenter: MoviePresenterOutput!
    var movieGenre = [MovieGenre]()
    
    
    func getGenre() {
        let source = "https://api.themoviedb.org/3/genre/movie/list?api_key=dbeb6ccadcf4200106585226109d1d61&language=en-US"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
                
            }
            
            if let movieDB = try? JSON(data: data!) {
                
                let genre = movieDB["genres"]
                
                
                for result in genre {
                    let id = result.1["id"].intValue
                    let name = result.1["name"].stringValue
                    
                    DispatchQueue.main.async {
                        self.movieGenre += [MovieGenre(id: id, name: name)]
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.presenter.reloadGenre()
            }
            
        }.resume()
    }
    
    
    func genreTotal() -> Int {
        movieGenre.count
    }
    
    
    func genreName(at indexPath: IndexPath) -> String {
        movieGenre[indexPath.row].name
    }
    
    func discoverMovie(at indexPath: IndexPath) {
        let genreID = movieGenre[indexPath.row].id
        presenter.discoverMovieByGenre(genreID)
    }
    
}
