//
//  MovieByGenreRouter.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation
import UIKit

protocol MovieByGenreRouterProtocol {
    static func start(genreID: Int) -> UIViewController
    func pushToMovieDetail(id: Int)
}

class MovieByGenreRouter: MovieByGenreRouterProtocol {
    
    var entry: UIViewController?
    
    static func start(genreID: Int) -> UIViewController {
        let router = MovieByGenreRouter()
        
        let view = MovieByGenreView()
        let presenter = MovieByGenrePresenter()
        let interactor = MovieByGenreInteractor()
        
        view.genreID = genreID
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return view
    }
    
    func pushToMovieDetail(id: Int) {
        let movieDetail = MovieDetailRouter.start(movieID: id)
        entry?.navigationController?.pushViewController(movieDetail, animated: true)
    }
}
