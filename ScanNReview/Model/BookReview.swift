//
//  BookReview.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/28/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import Foundation
import SwiftyJSON


struct BookReview {
    
    var snippet: String
    var source: String
    var reviewLink: String
    var positiveOrNegative: String
    var starRating: String
    var reviewDate: String
    var smileyOrSad: String
    var sourceLogo: String
    
    init(json: JSON){
        self.snippet = json["snippet"].stringValue
        self.source = json["source"].stringValue
        self.reviewLink = json["review_link"].stringValue
        self.positiveOrNegative = json["pos_or_neg"].stringValue
        self.starRating = json["star_rating"].stringValue
        self.reviewDate = json["review_date"].stringValue
        self.smileyOrSad = json["smiley_or_sad"].stringValue
        self.sourceLogo = json["source_logo"].stringValue
    }
}
