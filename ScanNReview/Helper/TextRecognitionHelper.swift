//
//  TextRecognitionHelper.swift
//  Scan n Review
//
//  Created by Tushar  Verma on 7/28/18.
//  Copyright © 2018 Tushar Verma. All rights reserved.
//

import UIKit
import FirebaseMLVision
import Alamofire
import SwiftyJSON



struct TextRecognition{
//    var isbnValues: [String] = []
//    var frameSublayer = CALayer()
//    
//    
//    // MARK: Text Recognition
//    func runTextRecognition(with image: UIImage, textDetector: VisionTextDetector) {
//        let visionImage = VisionImage(image:image)
//        textDetector.detect(in: visionImage) { features, error in
//            self.processResult(from: features, error:error, image: image)
//        }
//        
//    }
//    
//    
//    func processResult(from text: [VisionText]?, error: Error?,image: UIImage) {
//        removeFrames()
//        guard let features = text, let image = UIImage() else{
//            return
//        }
//        for text in features {
//            var i = 0
//            if let block = text as? VisionTextBlock {
//                for line in block.lines {
//                    if line.elements[0].text.contains("ISBN") {
//
//                        let isbn = line.elements[1].text
//                        isbnValues.append(isbn)
//                        
//                    }
//                }
//            }
//        }
//        let isbn = isbnValues[0].replacingOccurrences(of: "-", with: "")
//        print(isbn)
//        API.getReview(isbnValue: isbn)
//        
//    }
//    
//    private func removeFrames() {
//        guard let sublayers = frameSublayer.sublayers else { return }
//        for sublayer in sublayers {
//            guard let frameLayer = sublayer as CALayer? else {
//                print("Failed to remove frame layer.")
//                continue
//            }
//            frameLayer.removeFromSuperlayer()
//        }
//    }
//    
//    func detectorOrientation(in image: UIImage) -> VisionDetectorImageOrientation {
//        switch image.imageOrientation {
//        case .up:
//            return .topLeft
//        case .down:
//            return .bottomRight
//        case .left:
//            return .leftBottom
//        case .right:
//            return .rightTop
//        case .upMirrored:
//            return .topRight
//        case .downMirrored:
//            return .bottomLeft
//        case .leftMirrored:
//            return .leftTop
//        case .rightMirrored:
//            return .rightBottom
//        }
//    }
//    
}
