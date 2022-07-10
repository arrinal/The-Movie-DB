//
//  ViewController.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 05/07/22.
//

import UIKit

protocol MovieViewProtocol {
    
    func reloadGenre()
}

class ViewController: UIViewController, MovieViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: MoviePresenterInput!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        presenter.fetchGenre()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupUI() {
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func reloadGenre() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.genreTotal()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.genreName(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.discoverMovie(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

