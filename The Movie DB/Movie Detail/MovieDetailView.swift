//
//  MovieDetailView.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import UIKit
import YouTubeiOSPlayerHelper


protocol MovieDetailViewProtocol {
    func updateData(vm: MovieDetail)
    func updateDataReview()
    func updateYoutubeTrailer(key: YoutubeTrailer)
}

class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    
    var movieID: Int!
    var presenter: MovieDetailPresenterInput!
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito-Bold", size: 30)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let movieGenre: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito", size: 12)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let movieOverview: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito-Bold", size: 15)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let movieReleaseDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito", size: 12)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let youtubePlayer: YTPlayerView = {
        let youtube = YTPlayerView()
        
        return youtube
    }()
    
    let reviewTitle: UILabel = {
        let label = UILabel()
        label.text = "Review"
        label.font = UIFont(name: "Nunito-Bold", size: 20)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupScrollView()
        setupUI()
        presenter.fetchMovieDetail(for: movieID)
        presenter.fetchReview(for: movieID)
        presenter.fetchTrailer(for: movieID)
        
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollStackViewContainer.addArrangedSubview(movieTitle)
        scrollStackViewContainer.addArrangedSubview(movieGenre)
        scrollStackViewContainer.addArrangedSubview(movieReleaseDate)
        scrollStackViewContainer.addArrangedSubview(movieOverview)
        scrollStackViewContainer.addArrangedSubview(youtubePlayer)
        scrollStackViewContainer.addArrangedSubview(reviewTitle)
        scrollStackViewContainer.addArrangedSubview(tableView)
        
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .white
        
        movieTitle.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor, constant: 10).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -10).isActive = true
        movieTitle.bottomAnchor.constraint(equalTo: movieGenre.topAnchor, constant: -10).isActive = true

        movieGenre.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        movieGenre.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10).isActive = true
        movieGenre.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -10).isActive = true
        movieGenre.bottomAnchor.constraint(equalTo: movieReleaseDate.topAnchor, constant: -10).isActive = true

        movieReleaseDate.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 10).isActive = true
        movieReleaseDate.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10).isActive = true
        movieReleaseDate.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -10).isActive = true
        movieReleaseDate.bottomAnchor.constraint(equalTo: movieOverview.topAnchor, constant: -10).isActive = true

        movieOverview.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 10).isActive = true
        movieOverview.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10).isActive = true
        movieOverview.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -10).isActive = true
        movieOverview.bottomAnchor.constraint(equalTo: youtubePlayer.topAnchor, constant: -10).isActive = true
        
        youtubePlayer.heightAnchor.constraint(equalToConstant: view.bounds.height / 4).isActive = true
        youtubePlayer.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor).isActive = true
        youtubePlayer.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor).isActive = true
        youtubePlayer.bottomAnchor.constraint(equalTo: reviewTitle.topAnchor, constant: -20).isActive = true
        
        reviewTitle.topAnchor.constraint(equalTo: youtubePlayer.bottomAnchor, constant: 20).isActive = true
        reviewTitle.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 10).isActive = true
        reviewTitle.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -10).isActive = true
            reviewTitle.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10).isActive = true

        tableView.topAnchor.constraint(equalTo: reviewTitle.bottomAnchor, constant: 10).isActive = true
        tableView.widthAnchor.constraint(equalTo: scrollStackViewContainer.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
    }
    
    func updateData(vm: MovieDetail) {
        movieTitle.text = vm.title
        movieReleaseDate.text = "Release Date: \(vm.releaseDate)"
        movieGenre.text = "Genre: \(vm.genre.joined(separator: ", "))"
        movieOverview.text = vm.overview
    }
    
    func updateDataReview() {
        tableView.reloadData()
        
    }
    
    func updateYoutubeTrailer(key: YoutubeTrailer) {
        youtubePlayer.load(withVideoId: key.trailerKey)
    }
}

extension MovieDetailView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.reviewTotal()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as! ReviewTableViewCell
        let movieReviewVM = presenter.getMovieReviewVM()
        
        cell.configure(authorReview: movieReviewVM[indexPath.row].author, ratingReview: movieReviewVM[indexPath.row].rating, review: movieReviewVM[indexPath.row].review)
        
        return cell
    }
    
    
    
}
