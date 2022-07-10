//
//  MovieDetailPresenter.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation

protocol MovieDetailPresenterInput {
    var interactor: MovieDetailInteractorProtocol! { get set }
    var router: MovieDetailRouterProtocol! { get set }
    
    func fetchMovieDetail(for movieID: Int)
    func fetchReview(for movieID: Int)
    func fetchTrailer(for movieID: Int)
    func reviewTotal() -> Int
    func getMovieReviewVM() -> [MovieReview]
}

protocol MovieDetailPresenterOutput {
    var view: MovieDetailViewProtocol! { get set }
    
    func updateData(vm: MovieDetail)
    func updateDataReview()
    func updateYoutubeTrailer(key: YoutubeTrailer)
}

class MovieDetailPresenter: MovieDetailPresenterInput {
    
    var interactor: MovieDetailInteractorProtocol!
    var view: MovieDetailViewProtocol!
    var router: MovieDetailRouterProtocol!
    
}

extension MovieDetailPresenter {
    
    func fetchMovieDetail(for movieID: Int) {
        interactor.fetchMovieDetail(for: movieID)
    }
    
    func fetchReview(for movieID: Int) {
        interactor.fetchReview(for: movieID)
    }
    
    func fetchTrailer(for movieID: Int) {
        interactor.fetchTrailer(for: movieID)
    }
    
    func reviewTotal() -> Int {
        interactor.reviewTotal()
    }
    
    func getMovieReviewVM() -> [MovieReview] {
        interactor.getMovieReviewVM()
    }

}

extension MovieDetailPresenter: MovieDetailPresenterOutput {
    
    func updateData(vm: MovieDetail) {
        view.updateData(vm: vm)
    }
    
    func updateDataReview() {
        view.updateDataReview()
    }
    
    func updateYoutubeTrailer(key: YoutubeTrailer) {
        view.updateYoutubeTrailer(key: key)
    }
    
}
