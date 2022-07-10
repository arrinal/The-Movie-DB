//
//  MovieByGenrePresenter.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation

protocol MovieByGenrePresenterInput {
    var interactor: MovieByGenreInteractorProtocol! { get set }
    var view: MovieByGenreViewProtocol! { get set }
    var router: MovieByGenreRouterProtocol! { get set }
    
    func fetchMovie(pagination: Bool, for genreID: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    func movieTotal() -> Int
    func movieName(at indexPath: IndexPath) -> String
    func movieDetail(at indexPath: IndexPath)
    func addData(data: [Movie])
    func getPaginatingStatus() -> Bool
}

protocol MovieByGenrePresenterOutput {
    func reloadMovie()
    func pushToMovieDetail(id: Int)
    
}

class MovieByGenrePresenter: MovieByGenrePresenterInput {
    
    var interactor: MovieByGenreInteractorProtocol!
    var view: MovieByGenreViewProtocol!
    var router: MovieByGenreRouterProtocol!
    
}

extension MovieByGenrePresenter {
    
    func fetchMovie(pagination: Bool, for genreID: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        interactor.fetchMovie(pagination: pagination, for: genreID, completion: completion)
    }
    
    func movieTotal() -> Int {
        interactor.movieTotal()
    }
    
    func movieName(at indexPath: IndexPath) -> String {
        interactor.movieName(at: indexPath)
    }
    
    func movieDetail(at indexPath: IndexPath) {
        interactor.movieDetail(at: indexPath)
    }
    
    func addData(data: [Movie]) {
        interactor.addData(data: data)
    }
    
    func getPaginatingStatus() -> Bool {
        interactor.getPaginatingStatus()
    }
}

extension MovieByGenrePresenter: MovieByGenrePresenterOutput {
    func reloadMovie() {
        view.reloadMovie()
    }
    
    func pushToMovieDetail(id: Int) {
        router.pushToMovieDetail(id: id)
    }
}
