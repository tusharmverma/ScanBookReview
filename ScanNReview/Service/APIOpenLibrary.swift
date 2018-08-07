//
//  APIOpenLibrary.swift
//  ScanNReview
//
//  Created by Tushar  Verma on 8/3/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import UIKit
import FirebaseMLVision
import Alamofire
import SwiftyJSON

struct APIOpenLibrary {
    static func infoFromOpenLibrary(isbnValue: String, completion: @escaping (BookCover) -> Void) {
        let apiLink = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbnValue)"

        Alamofire.request(URL(string: apiLink)!).responseJSON { (response) in
            let json = JSON(response.value as Any)
            let bookCover = json["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
            let bookC = BookCover(bookCover: bookCover)
            //print("\n\n\nHere!!!!!!!!!!!  -> \(bookCover)")
            completion(bookC)
        }

    }
}
