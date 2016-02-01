//
//  PopupViewButton.swift
//  XTPopupView
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

class PopupViewButton: UIView {
    
    var button: UIButton?
    
    init(title: String, type: PopupViewItemType, withUnderline: Bool) {
        super.init(frame: CGRectZero)
        createButton(title, type: type, withUnderline: withUnderline)
    }
    
    private func createButton(title: String, type: PopupViewItemType, withUnderline: Bool) {
        button = UIButton(type: UIButtonType.System)
        button?.setTitle(title, forState: UIControlState.Normal)
        switch(type) {
        case .Normal, .Cancel:
            button?.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        case .HighLight:
            button?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        case .Disabled:
            button?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            button?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        }
        
        addSubview(button!)
        
        button?.snp_makeConstraints(closure: { (make) -> Void in
            make.edges.equalTo(self)
        })
        
        if withUnderline {
            let underlineView = UIView()
            underlineView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            addSubview(underlineView)
            underlineView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.bottom.equalTo(self)
                make.height.equalTo(1)
            })
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
