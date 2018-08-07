//
//  APIService.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/28/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import UIKit
import FirebaseMLVision
import Alamofire
import SwiftyJSON

struct APIBookInfo {
    static func getInfo(isbnValue: String, completion: @escaping (Book) -> Void) {
        //print("Testing json API")
        let apiKey = "bb8987412da0754de72bbf98f8c94b2796f477f6"
        let apiLink = "http://idreambooks.com/api/books/reviews.json?q=\(isbnValue)&key=\(apiKey)"
        
        Alamofire.request(URL(string: apiLink)!).responseJSON { (response) in
            let json = JSON(response.value as Any)
            let title = json["book"]["title"].stringValue
            let subTitle = json["book"]["sub_title"].stringValue
            let author = json["book"]["author"].stringValue
            let detailLink = json["book"]["detail_link"].stringValue
            let genre = json["book"]["genre"].stringValue
            let pages = json["book"]["pages"].stringValue
            let releaseDate = json["book"]["release_date"].stringValue
            let reviewCount = json["book"]["review_count"].stringValue

            let book = Book(title: title, subTitle: subTitle, author: author, detailLink: detailLink, genre: genre, pages: pages, releaseDate: releaseDate, reviewCount:reviewCount)
//            print("Title: ", book.title)
//            print("Sub Title: ", book.subTitle)
//            print("Author: ", book.author)
//            print("Link: ", book.detailLink)
//            print("Genre: ", book.genre)
//            print("Pages: ", book.pages)
//            print("Release Date: ", book.releaseDate)
            completion(book)
        }

    }
}
