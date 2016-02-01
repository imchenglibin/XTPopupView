//
//  PopupView.swift
//  XTPopupView
//
//  Created by imchenlibin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

public enum PopupViewCustomViewPosition {
    case Center, Bottom
}

public class PopupView: UIView {
    private var _tapGesture: UITapGestureRecognizer?
    private var _customViewPositin: PopupViewCustomViewPosition = .Bottom
    public var customView: UIView?
    private var _size: CGSize = CGSize(width: 0, height: 0)
    
    public func show() {
        let attachView: UIView = Window.sharedWindow.mainView()
        
        attachView.addSubview(self)
        
        self.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(attachView)
        }
        
        if let _ = _tapGesture {
            attachView .addGestureRecognizer(_tapGesture!)
        } else {
            _tapGesture = UITapGestureRecognizer(target: self, action: Selector("tap:"))
            attachView.addGestureRecognizer(_tapGesture!)
        }
        
        if _customViewPositin == .Bottom {
            Window.sharedWindow.hidden = false
            self.customView!.layer.position = CGPoint(x: attachView.bounds.size.width / 2, y: attachView.bounds.size.height + self._size.height / 2)
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                 self.customView!.layer.position = CGPoint(x: attachView.bounds.size.width / 2, y: attachView.bounds.size.height - self._size.height / 2)
            })
        } else {
            Window.sharedWindow.hidden = false
            customView?.alpha = 0
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.customView?.alpha = 1.0
            })
        }
    }
    
    func tap(tapGesture: UITapGestureRecognizer) {
        if self is AlertView {
            if let inputTextField = (self as! AlertView).inputTextField {
                inputTextField.resignFirstResponder()
            } else {
                hide()
            }
        } else {
            hide()
        }
    }
    
    public func hide() {
        let attachView: UIView = Window.sharedWindow.mainView()
        
        if _customViewPositin == .Bottom {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.customView!.layer.position = CGPoint(x: attachView.bounds.size.width / 2, y: attachView.bounds.size.height + self._size.height / 2)
                }, completion: { (Bool) -> Void in
                    Window.sharedWindow.hidden = true
                    attachView.removeGestureRecognizer(self._tapGesture!)
                    self.removeFromSuperview()
            })
        } else {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.customView?.alpha = 0
                }, completion: { (Bool) -> Void in
                    Window.sharedWindow.hidden = true
                    attachView.removeGestureRecognizer(self._tapGesture!)
                    self.removeFromSuperview()
            })
        }
    }
    
    public func setCustomView(customView: UIView, position: PopupViewCustomViewPosition) {
        self.customView = customView
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
