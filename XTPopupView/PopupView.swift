//
//  PopupView.swift
//  XTPopupView
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

public enum PopupViewCustomViewPosition {
    case Center, Bottom
}

public class PopupView: UIView {
    
    private var _customViewPositin: PopupViewCustomViewPosition = .Bottom
    private var _customView: UIView?
    private var _size: CGSize = CGSize(width: 0, height: 0)
    
    public func show() {
        let attachView: UIView = Window.sharedWindow.mainView()
        
        attachView.addSubview(self)
        
        self.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(attachView)
        }
        
        if _customViewPositin == .Bottom {
            Window.sharedWindow.hidden = false
            self._customView!.layer.position = CGPoint(x: attachView.bounds.size.width / 2, y: attachView.bounds.size.height + self._size.height / 2)
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                 self._customView!.layer.position = CGPoint(x: attachView.bounds.size.width / 2, y: attachView.bounds.size.height - self._size.height / 2)
            })
        } else {
            
        }
    }
    
    public func hide() {
        let attachView: UIView = Window.sharedWindow.mainView()
        
        if _customViewPositin == .Bottom {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self._customView!.layer.position = CGPoint(x: attachView.bounds.size.width / 2, y: attachView.bounds.size.height + self._size.height / 2)
                }, completion: { (Bool) -> Void in
                    Window.sharedWindow.hidden = true
                    self.removeFromSuperview()
            })
        } else {
            
        }
    }
    
    public func setCustomView(customView: UIView, position: PopupViewCustomViewPosition) {
        _customView = customView
        _customViewPositin = position
        _size = CGSize(width: customView.frame.width, height: customView.frame.size.height)
        addSubview(customView)
        if position == .Bottom {
            customView.snp_makeConstraints { (make) -> Void in
                make.bottom.equalTo(self)
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.height.equalTo(customView.frame.size.height)
            }
        } else {
            customView.snp_makeConstraints { (make) -> Void in
                make.center.equalTo(self)
                make.width.equalTo(customView.frame.size.width)
                make.height.equalTo(customView.frame.size.height)
            }
        }
    }
}