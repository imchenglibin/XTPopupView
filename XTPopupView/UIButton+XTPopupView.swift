//
//  UIButton+XTPopupView.swift
//  XTPopupView
//
//  Created by imchenglibin on 16/2/2.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit

extension UIButton {
    public class func xt_button(title: String, type:PopupViewItemType)->UIButton {
        let button = UIButton(type: UIButtonType.System)
        button.setTitle(title, forState: UIControlState.Normal)
        button.backgroundColor = UIColor.whiteColor()
        switch(type) {
        case .Normal, .Cancel:
            button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        case .HighLight:
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        case .Disabled:
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        }
        return button
    }
}