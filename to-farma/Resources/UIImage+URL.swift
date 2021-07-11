//
//  UIImage+URL.swift
//  to-farma
//
//  Created by Melissa Villalobos on 11/6/21.
//

import Foundation
import UIKit

extension UIImageView {
    func fetchImageFrom(url: String) -> UIImage? {
        guard
            let convertedUrl = URL(string: url),
            let data = try? Data(contentsOf: convertedUrl) as Data
        else {
            return nil
        }
        return UIImage(data: data)
    }
}       
extension UIImageView {

    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        let imageCache = NSCache<NSString, UIImage>()

        self.image = nil

        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
