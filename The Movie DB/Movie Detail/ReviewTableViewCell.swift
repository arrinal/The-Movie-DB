//
//  ReviewTableViewCell.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    static let identifier = "reviewCell"
    
    let authorReview: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito-Bold", size: 15)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let ratingReview: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito-Bold", size: 12)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let review: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Nunito", size: 15)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(authorReview)
        contentView.addSubview(ratingReview)
        contentView.addSubview(review)
        
        authorReview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        authorReview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        authorReview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        authorReview.bottomAnchor.constraint(equalTo: ratingReview.topAnchor, constant: -10).isActive = true
        
        ratingReview.topAnchor.constraint(equalTo: authorReview.bottomAnchor, constant: 10).isActive = true
        ratingReview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        ratingReview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        ratingReview.bottomAnchor.constraint(equalTo: review.topAnchor, constant: -10).isActive = true
        
        review.topAnchor.constraint(equalTo: ratingReview.bottomAnchor, constant: 10).isActive = true
        review.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        review.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        review.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func configure(authorReview: String, ratingReview: Int, review: String) {
        
        self.authorReview.text = authorReview
        self.ratingReview.text = "Rating: \(ratingReview)/10"
        self.review.text = "\"\(review)\""
        
        
    }

}
