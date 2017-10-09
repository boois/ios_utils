//
//  XMToastView.swift
//  XMSwift
//
//  Created by mifit on 16/9/19.
//  Copyright © 2016年 Mifit. All rights reserved.
//

import UIKit

class BooisToast {
    
    public static var bgColor:UIColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.8)
    public static var textColor:UIColor = UIColor.white
    public static var msg :String = "操作成功"
    public static var  duration:TimeInterval = 1.0
    public static var toastView: UIView? = nil
    
    public static func show(inView:UIView,icon:UIImage?,bgColor:UIColor, textColor:UIColor, msg:String, duration:TimeInterval) {
        if BooisToast.toastView == nil {
            BooisToast.toastView = Bundle.main.loadNibNamed("Toast", owner: nil, options: nil)?.first as? UIView
        }
        BooisToast.toastView?.frame = inView.frame
        let img = BooisToast.toastView!.viewWithTag(99) as? UIImageView
        let txt = BooisToast.toastView!.viewWithTag(88) as? UILabel
        let box = BooisToast.toastView!.viewWithTag(77)
        
        img?.image = icon
        txt?.text = msg
        txt?.textColor = textColor
        box?.backgroundColor = bgColor
        
        
        inView.addSubview(BooisToast.toastView!)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            img?.image = nil
            txt?.text = BooisToast.msg
            BooisToast.toastView!.removeFromSuperview()
        }
    }
    public static func show(inView:UIView,icon:UIImage?,msg:String) {
        BooisToast.show(inView: inView, icon: icon, bgColor: BooisToast.bgColor, textColor: BooisToast.textColor, msg: msg, duration: BooisToast.duration)
    }
    
    public static func show(inView:UIView,icon:UIImage?,msg:String, duration:TimeInterval) {
        BooisToast.show(inView: inView, icon: icon, bgColor: BooisToast.bgColor, textColor: BooisToast.textColor, msg: msg, duration: duration)
    }
}


