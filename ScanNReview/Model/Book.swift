//
//  Book.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/28/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import Foundation

struct Book {
    var title: String
    var subTitle: String
    var author: String
    var detailLink: String
    var genre: String
    var pages: String
    var releaseDate: String
    var reviewCount: String
    
    init(title: String, subTitle:String, author: String, detailLink: String, genre: String, pages: String, releaseDate:String, reviewCount: String) {
        self.title = title
        self.subTitle = subTitle
        self.author = author
        self.detailLink = detailLink
        self.genre = genre
        self.pages = pages
        self.releaseDate = releaseDate
        self.reviewCount = reviewCount
    }
}
