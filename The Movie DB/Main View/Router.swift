//
//  Router.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 05/07/22.
//

import Foundation
import UIKit

typealias EntryPoint = MovieViewProtocol & UIViewController

protocol MovieRouterProtocol {
    
    var entry: EntryPoint? { get }
    
    static func start() -> MovieRouterProtocol
    func pushToMovieByGenre(_ genreID: Int)
}


class MovieDBRouter: MovieRouterProtocol {
    
    var entry: EntryPoint?
    
    static func start() -> MovieRouterProtocol {
        let router = MovieDBRouter()
        
        let view = ViewController()
        let presenter = MoviePresenter()
        let interactor = MovieInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as EntryPoint
        
        
        
        return router
    }
    
    
    func pushToMovieByGenre(_ genreID: Int) {
        let movieByGenre = MovieByGenreRouter.start(genreID: genreID)
        
        entry?.navigationController?.pushViewController(movieByGenre, animated: true)
    }
}
