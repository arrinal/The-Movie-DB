//
//  Presenter.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 05/07/22.
//

import Foundation

protocol MoviePresenterInput {
    var interactor: MovieInteractorProtocol! { get set }
    var router: MovieRouterProtocol! { get set }
    
    func fetchGenre()
    func genreTotal() -> Int
    func genreName(at indexPath: IndexPath) -> String
    func discoverMovie(at indexPath: IndexPath)
}

protocol MoviePresenterOutput {
    
    var view: MovieViewProtocol! { get set }
    func reloadGenre()
    func discoverMovieByGenre(_ genreID: Int)
}

class MoviePresenter: MoviePresenterInput {
    
    var interactor: MovieInteractorProtocol!
    var view: MovieViewProtocol!
    var router: MovieRouterProtocol!
}

extension MoviePresenter {

    func fetchGenre() {
        interactor.getGenre()
    }
    
    
    func genreTotal() -> Int {
        interactor.genreTotal()
    }
    
    func genreName(at indexPath: IndexPath) -> String {
        interactor.genreName(at: indexPath)
    }
    
    func discoverMovie(at indexPath: IndexPath) {
        interactor.discoverMovie(at: indexPath)
    }
}

extension MoviePresenter: MoviePresenterOutput {
    
    func reloadGenre() {
        view.reloadGenre()
    }
    
    func discoverMovieByGenre(_ genreID: Int) {
        router.pushToMovieByGenre(genreID)
    }
    
}
