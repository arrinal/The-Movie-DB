//
//  The_Movie_DBTests.swift
//  The Movie DBTests
//
//  Created by Arrinal Sholifadliq on 05/07/22.
//

import XCTest
@testable import The_Movie_DB

class The_Movie_DBTests: XCTestCase {
    
    var presenter: MoviePresenterInput & MoviePresenterOutput = MoviePresenter()
    var interactor: MovieInteractorProtocol! = MovieInteractor()
    var router: MovieRouterProtocol! = MovieDBRouter()
    var view: MovieViewProtocol! = ViewController()
    
    var presenterMovie: MovieByGenrePresenterInput & MovieByGenrePresenterOutput = MovieByGenrePresenter()
    var interactorMovie: MovieByGenreInteractorProtocol! = MovieByGenreInteractor()
    var routerMovie: MovieByGenreRouterProtocol! = MovieByGenreRouter()
    var viewMovie: MovieByGenreViewProtocol! = MovieByGenreView()
    
    var presenterMovieDetail: MovieDetailPresenterInput & MovieDetailPresenterOutput = MovieDetailPresenter()
    var interactorMovieDetail: MovieDetailInteractorProtocol! = MovieDetailInteractor()
    var routerMovieDetail: MovieDetailRouterProtocol! = MovieDetailRouter()
    var viewMovieDetail: MovieDetailViewProtocol! = MovieDetailView()
    
    override func setUp() {
        super.setUp()
        
        self.interactor.presenter = presenter
        self.presenter.router = router
        self.presenter.interactor = interactor
        self.presenter.view = view
        
        self.interactorMovie.presenter = presenterMovie
        self.presenterMovie.router = routerMovie
        self.presenterMovie.interactor = interactorMovie
        self.presenterMovie.view = viewMovie
        
        self.interactorMovieDetail.presenter = presenterMovieDetail
        self.presenterMovieDetail.router = routerMovieDetail
        self.presenterMovieDetail.interactor = interactorMovieDetail
        self.presenterMovieDetail.view = viewMovieDetail
        
    }
    
    func test() {
        
        interactor.movieGenre = [MovieGenre(id: 1, name: "Action")]
        XCTAssertEqual(presenter.genreTotal(), 1)
        XCTAssertEqual(presenter.genreName(at: IndexPath(row: 0, section: 0)), "Action")
    }
    
    func test_movie_by_genre() {
        
        interactorMovie.movies = [Movie(id: 1, original_title: "The Avengers"), Movie(id: 2, original_title: "Top Gun: Maverick")]
        XCTAssertEqual(presenterMovie.movieTotal(), 2)
        XCTAssertEqual(presenterMovie.movieName(at: IndexPath(row: 1, section: 0)), "Top Gun: Maverick")
        
    }
    
    func test_movie_detail() {
        
        interactorMovieDetail.movieReviewVM = [MovieReview(author: "John", rating: 7, review: "Lorem ipsum dolor sit amet"), MovieReview(author: "Thomas", rating: 9, review: "Good"), MovieReview(author: "Joko", rating: 2, review: "Bad")]
        XCTAssertEqual(presenterMovieDetail.reviewTotal(), 3)
        XCTAssertNotNil(presenterMovieDetail.getMovieReviewVM())
        XCTAssertEqual(presenterMovieDetail.getMovieReviewVM()[0].author, "John")
        
    }
    
    
}
