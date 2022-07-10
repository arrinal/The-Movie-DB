//
//  MovieDetailRouter.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    static func start(movieID: Int) -> UIViewController
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    static func start(movieID: Int) -> UIViewController {
        let router = MovieDetailRouter()
        
        let view = MovieDetailView()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        
        view.movieID = movieID
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
}
