//
//  MovieByGenreView.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import UIKit

protocol MovieByGenreViewProtocol {
    
    func reloadMovie()
    
}

class MovieByGenreView: UIViewController, MovieByGenreViewProtocol, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var genreID: Int!
    var presenter: MovieByGenrePresenterInput!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "discoverMovieCell")
        table.rowHeight = UITableView.automaticDimension
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        presenter.fetchMovie(pagination: false, for: genreID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.presenter.addData(data: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(_):
                break
            }
        }
    }
    
    func setupUI() {
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func reloadMovie() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieTotal()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverMovieCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = presenter.movieName(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.movieDetail(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height {
            
            guard !presenter.getPaginatingStatus() else { return }
            
            self.tableView.tableFooterView = createSpinnerFooter()
            
            presenter.fetchMovie(pagination: true, for: genreID) { [weak self] result in
                
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                
                switch result {
                case .success(let moreData):
                    self?.presenter.addData(data: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                case .failure(_):
                    break
                }
            }
        }
    }


}
