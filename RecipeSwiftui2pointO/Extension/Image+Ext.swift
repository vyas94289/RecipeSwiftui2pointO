//
//  Image+Ext.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/02/21.
//

import UIKit

extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb: Float) -> UIImage? {
        let sizeInBytes = Int(expectedSizeInMb * 1024 * 1024)
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count <= sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue = CGFloat(sizeInBytes) * (CGFloat(compressingValue) / CGFloat(data.count))
                }
            }
        }
        
        if let data = imgData {
            if ( data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}


/*totalSize = 5mb
 
 compressionQuality can be 0 to 1

 need to compress less than 1 mb

 then how to calculate compressionQuality*/
