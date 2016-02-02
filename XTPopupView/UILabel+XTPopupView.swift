//
//  UILabel+XTPopupView.swift
//  XTPopupView
//
//  Created by imchenglibin on 16/2/2.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit

extension UILabel {
    public class func xt_label(title: String)->UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.whiteColor()
        label.numberOfLines = 0
        label.text = title
        label.textColor = UIColor.darkGrayColor()
        return label
    }
}
