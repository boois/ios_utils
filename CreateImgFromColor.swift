//
//  CreateImgFromColor.swift
//  Client
//
//  Created by boois on 2017/10/5.
//  Copyright © 2017年 xiangqianjin. All rights reserved.
//
import UIKit

class ImageFactory {
    public static func createImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
}
