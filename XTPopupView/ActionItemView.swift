//
//  ActionItemView.swift
//  XTPopupView
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

class ActionItemView: UIView {
    init(title: String, underlineHeight: CGFloat, type: ActionItemType) {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        let underline = UIView()
        underline.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.addSubview(underline)
        underline.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(underlineHeight)
        }
        
        let button = UIButton(type: UIButtonType.System)
        switch(type) {
        case .Normal:
            button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        case .HighLight:
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        case .Disabled:
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        }
        
        button.setTitle(title, forState: UIControlState.Normal)
        button.backgroundColor = UIColor.whiteColor()
        self.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(underline.snp_top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(target: AnyObject, action: Selector, forControlEvents: UIControlEvents, tag: Int) {
        let button = self.subviews.last as! UIButton
        button.tag = tag
        button.addTarget(target, action: action, forControlEvents: forControlEvents)
    }
}
