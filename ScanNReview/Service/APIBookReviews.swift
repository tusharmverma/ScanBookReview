//
//  APIBookReviews.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 8/1/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import UIKit
import FirebaseMLVision
import Alamofire
import SwiftyJSON

struct APIBookReviews {
    
    static func getReviews(isbnValue: String, completion: @escaping ([BookReview]) -> Void) {
        
        let apiKey = "bb8987412da0754de72bbf98f8c94b2796f477f6"
        
        let apiLink = "http://idreambooks.com/api/books/reviews.json?q=\(isbnValue)&key=\(apiKey)"
        
        Alamofire.request(URL(string: apiLink)!).responseJSON { (response) in
            let json = JSON(response.value as Any)
            var bookReviews = [BookReview] ()
            let criticReviews = json["book"]["critic_reviews"].arrayValue
            for bookJSON in criticReviews {
                let review = BookReview(json: bookJSON)
                bookReviews.append(review)
            }
            //print("Array of bookreviews:", bookReviews)
//            for bookReview in bookReviews {
//                print("Snippet: ", bookReview.snippet)
//            }
            completion(bookReviews)
        }
        
    }
}
