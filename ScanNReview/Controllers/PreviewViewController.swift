//
//  PreviewViewController.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/30/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import FirebaseMLVision
import Alamofire
import SwiftyJSON

class PreviewViewController: UIViewController{
    var image: UIImage!
    var textDetector: VisionTextDetector!
    var book: Book!
    var bookReview: [BookReview]!
    var bookCover: BookCover!
    /// A string holding current results from detection.
    var resultsText = ""
    
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    /// An overlay view that displays detection annotations.
    private lazy var annotationOverlayView: UIView = {
        precondition(isViewLoaded)
        let annotationOverlayView = UIView(frame: .zero)
        annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return annotationOverlayView
    }()
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.isHidden = true
        photo.image = self.image
        // Initialize the on-device text dectector
        let vision = Vision.vision()
        textDetector = vision.textDetector()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    // MARK: Text Recognition

    @IBAction func doneButtonPressed(_ sender: Any) {
        // Activity Indicator
        doneButton.isEnabled = false
        if activity.isAnimating == true{
            activity.isHidden = true
            activity.stopAnimating()
        }
        else{
            activity.isHidden = false
            activity.startAnimating()
        }
        detectTexts(image: image) { (book, bookReview, bookCover) in
            self.book = book
            self.bookReview = bookReview
            self.bookCover = bookCover
            self.performSegue(withIdentifier: "goToResults", sender: self)

        }
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ResultViewController
        vc?.bookI = self.book
        vc?.bookR = self.bookReview
        vc?.bookC = self.bookCover
    }
    
    private func transformMatrix() -> CGAffineTransform {
        guard let image = photo.image else { return CGAffineTransform() }
        let imageViewWidth = photo.frame.size.width
        let imageViewHeight = photo.frame.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let imageViewAspectRatio = imageViewWidth / imageViewHeight
        let imageAspectRatio = imageWidth / imageHeight
        let scale = (imageViewAspectRatio > imageAspectRatio) ?
            imageViewHeight / imageHeight :
            imageViewWidth / imageWidth
        
        // Image view's `contentMode` is `scaleAspectFit`, which scales the image to fit the size of the
        // image view by maintaining the aspect ratio. Multiple by `scale` to get image's original size.
        let scaledImageWidth = imageWidth * scale
        let scaledImageHeight = imageHeight * scale
        let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
        let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
        
        var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }
    
    /// Detects texts on the specified image and draws a frame around the detect texts using On-Device
    /// text API.
    ///
    /// - Parameter image: The image.
    func detectTexts(image: UIImage?, completion: @escaping(Book, [BookReview], BookCover)->()) {
        guard let image = image else { return }
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START detect_text]
        textDetector.detect(in: visionImage) { features, error in
            guard error == nil, let features = features, !features.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "On-Device text detection failed with error: \(errorString)"
                // [END_EXCLUDE]
                let alert = UIAlertController(title: "Unable to scan the ISBN ?", message: "It's recommended to retake a picture and continue.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.doneButton.isEnabled = true
                self.activity.stopAnimating()
                self.activity.isHidden = true
                return
            }
            
            // [START_EXCLUDE]
            self.resultsText = features.map { feature in
                let transformedRect = feature.frame.applying(self.transformMatrix())
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: UIColor.green
                )

                return "\(feature.text)"
                }.joined(separator: " ")
            
            
            let resultsArray = self.resultsText.split(separator: " ")
            var isbnArray = [String]()
            for index in 0..<resultsArray.count - 1 {
                let word = resultsArray[index]
                if word.contains("ISBN") {
                    let tempISBN = String(resultsArray[index+1])
                    isbnArray.append(tempISBN)
                }
//                else{
//                    let alert = UIAlertController(title: "Unable to scan the ISBN ?", message: "It's recommended to retake a picture and continue.", preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                    self.present(alert, animated: true)
//                    self.doneButton.isEnabled = true
//                    self.activity.stopAnimating()
//                    self.activity.isHidden = true
//                }
            }

            if isbnArray.count == 0 {
                let alert = UIAlertController(title: "Unable to scan the ISBN ?", message: "It's recommended to retake a picture and continue.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.doneButton.isEnabled = true
                self.activity.stopAnimating()
                self.activity.isHidden = true
                return }
            let isbnValue = isbnArray[0].replacingOccurrences(of: "-", with: "")
            APIBookInfo.getInfo(isbnValue: isbnValue) {(book) in
                //print(book)
                APIBookReviews.getReviews(isbnValue: isbnValue){ (bookReview) in
                    //print(bookReview)
                    APIOpenLibrary.infoFromOpenLibrary(isbnValue: isbnValue) {(bookCover) in
                        completion(book,bookReview,bookCover)
                    }
                    
                }
            }
            // [END_EXCLUDE]
        }
}
}

private enum Constants {
    static let detectionNoResultsMessage = "No results returned."
}


