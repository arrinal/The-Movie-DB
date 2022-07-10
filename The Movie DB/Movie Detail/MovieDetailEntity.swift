//
//  MovieDetailEntity.swift
//  The Movie DB
//
//  Created by Arrinal Sholifadliq on 08/07/22.
//

import Foundation

struct MovieDetail {
    let id: Int
    let title: String
    let genre: [String]
    let overview: String
    let releaseDate: String
}

struct MovieReview {
    let author: String
    let rating: Int
    let review: String
}

struct YoutubeTrailer {
    let trailerKey: String
}
