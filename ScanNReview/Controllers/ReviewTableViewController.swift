//
//  ReviewTableViewController.swift
//  ScanNReview
//
//  Created by Tushar  Verma on 8/8/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//


import Foundation
import UIKit
import FirebaseMLVision
import Alamofire
import SwiftyJSON
import Kingfisher

class ReviewTableViewController: UIViewController{
    // MARK: Text Recognition
    var bookI: Book!
    var bookR: [BookReview]!
    var bookC: BookCover!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ResultViewController
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
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goBackToResults", sender: self)
    }
    
}


extension ReviewTableViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookR.count == 0 {
            self.tableView.setEmptyMessage("No Reviews Available")
        } else {
            self.tableView.restore()
        }
        return bookR.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        cell.setGradientForResultTableViewBackground(colorOne: Colors.darkGrey, colorTwo: Colors.darkGrey)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.starRating.adjustsFontSizeToFitWidth = true
        cell.starRating.minimumScaleFactor = 0.2
        cell.source.adjustsFontSizeToFitWidth = true
        cell.source.minimumScaleFactor = 0.2
        cell.snippet.adjustsFontSizeToFitWidth = true
        cell.snippet.minimumScaleFactor = 0.2
        let url = URL(string: bookR[indexPath.row].sourceLogo)
        cell.sourceLogo.kf.setImage(with: url)
        cell.snippet.text = bookR[indexPath.row].snippet
        cell.source.text = "From: \(bookR[indexPath.row].source)"
        if Int(bookR[indexPath.row].starRating) == 1 {
            cell.starRating.text = "⭐️"
        }else if Int(bookR[indexPath.row].starRating) == 2 {
            cell.starRating.text = "⭐️⭐️"
        }else if Int(bookR[indexPath.row].starRating) == 3 {
            cell.starRating.text = "⭐️⭐️⭐️"
        } else if Int(bookR[indexPath.row].starRating) == 4 {
            cell.starRating.text = "⭐️⭐️⭐️⭐️"
        } else if Int(bookR[indexPath.row].starRating) == 5 {
            cell.starRating.text = "⭐️⭐️⭐️⭐️⭐️"
        }
        cell.date.text = bookR[indexPath.row].reviewDate
        return cell
    }


}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
