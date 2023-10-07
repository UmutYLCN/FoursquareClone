//
//  URLConvert.swift
//  FoursquareClone
//
//  Created by umut yalçın on 7.10.2023.
//

import Foundation
import UIKit



extension UIImageView {
    
    func loadUrl(url:URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
