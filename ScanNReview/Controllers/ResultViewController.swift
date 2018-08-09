//
//  ResultViewController.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/28/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import Foundation
import UIKit
import FirebaseMLVision
import Alamofire
import SwiftyJSON
import Kingfisher

class ResultViewController: UIViewController{
    // MARK: Text Recognition
    var bookI: Book!
    var bookR: [BookReview]!
    var bookC: BookCover!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bookLogoImageView: UIImageView!
    @IBOutlet weak var tileLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var reScanBookButton: UIButton!
    @IBOutlet weak var criticReviewButton: UIButton!
    
    
    func showBookData(){
        let url = URL(string: bookC.bookCover)
        bookLogoImageView.kf.setImage(with: url)
        tileLabel.text = bookI.title
        subTitleLabel.text = bookI.subTitle
        releaseDateLabel.text = bookI.releaseDate
        authorLabel.text = bookI.author
        genreLabel.text = bookI.genre
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.setGradientForResultTableViewBackground(colorOne: Colors.lightBlue, colorTwo: Colors.kindaBlue)
        view.setGradientResultViewBackground(colorOne: Colors.kindaWhite, colorTwo: Colors.kindaWhite)
        criticReviewButton.setGradientButtonBackground(colorOne: Colors.softBlue, colorTwo: Colors.kindaBlue)
        reScanBookButton.setGradientButtonBackground(colorOne: Colors.softBlue, colorTwo: Colors.kindaBlue)
        tileLabel.adjustsFontSizeToFitWidth = true
        tileLabel.minimumScaleFactor = 0.2
        subTitleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.minimumScaleFactor = 0.2
        //tableView.delegate = self
        //tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 200
        //tableView.reloadData()
        showBookData()
        // use kingfisher to download images from url
        // Initialize the on-device text dectector
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ReviewTableViewController
        vc?.bookR = self.bookR
        vc?.bookI = self.bookI
        vc?.bookC = self.bookC
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    @IBAction func criticReviewButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToReviews", sender: self)
    }
}


//extension ResultTableViewController: UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if bookR.count == 0 {
//            self.tableView.setEmptyMessage("No Reviews Available")
//        } else {
//            self.tableView.restore()
//        }
//        return bookR.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as! ResultTableViewCell
//        cell.setGradientForResultTableViewBackground(colorOne: Colors.darkGrey, colorTwo: Colors.darkGrey)
//        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        let url = URL(string: bookR[indexPath.row].sourceLogo)
//        cell.sourceLogo.kf.setImage(with: url)
//        cell.snippet.text = bookR[indexPath.row].snippet
//        cell.source.text = "From: \(bookR[indexPath.row].source)"
//        if Int(bookR[indexPath.row].starRating) == 1 {
//            cell.starRating.text = "⭐️"
//        }else if Int(bookR[indexPath.row].starRating) == 2 {
//            cell.starRating.text = "⭐️⭐️"
//        }else if Int(bookR[indexPath.row].starRating) == 3 {
//            cell.starRating.text = "⭐️⭐️⭐️"
//        } else if Int(bookR[indexPath.row].starRating) == 4 {
//            cell.starRating.text = "⭐️⭐️⭐️⭐️"
//        } else if Int(bookR[indexPath.row].starRating) == 5 {
//            cell.starRating.text = "⭐️⭐️⭐️⭐️⭐️"
//        }
//        cell.date.text = bookR[indexPath.row].reviewDate
//        return cell
//    }
//
//
//}
//
//extension UITableView {
//
//    func setEmptyMessage(_ message: String) {
//        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
//        messageLabel.text = message
//        messageLabel.textColor = .black
//        messageLabel.numberOfLines = 0;
//        messageLabel.textAlignment = .center;
//        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
//        messageLabel.sizeToFit()
//
//        self.backgroundView = messageLabel;
//        self.separatorStyle = .none;
//    }
//
//    func restore() {
//        self.backgroundView = nil
//        self.separatorStyle = .singleLine
//    }
//}
