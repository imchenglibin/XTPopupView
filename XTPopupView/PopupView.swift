//
//  PopupView.swift
//  XTPopupView
//
//  Created by imchenlibin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

public class PopupView: UIView {
    private var _tapGesture: UITapGestureRecognizer?
    
    public var attachView: UIView {
        get {
            return Window.sharedWindow.mainView()
        }
    }
    
    public func show() {
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
        Window.sharedWindow.hidden = false
        attachView.alpha = 0
        UIView.animateWithDuration(0.15) { [unowned self]() -> Void in
            self.attachView.alpha = 1.0
        }
        self.animationWhenShow({ () -> Void in
        })
    }
    
    public func animationWhenShow(complete:()->Void) {
        complete()
    }
    
    func tap(tapGesture: UITapGestureRecognizer) {
        if !handleTap() {
            hide()
        }
    }
    
    public func handleTap()->Bool {
        return false
    }
    
    public func hide() {
        UIView.animateWithDuration(0.15) { [unowned self]() -> Void in
            self.attachView.alpha = 0
        }
        animationWhenHide { [unowned self]() -> Void in
            Window.sharedWindow.hidden = true
            self.attachView.alpha = 1.0
            self.attachView.removeGestureRecognizer(self._tapGesture!)
            self.removeFromSuperview()
        }
    }
    
    public func animationWhenHide(complete:()->Void) {
        complete()
    }
}
