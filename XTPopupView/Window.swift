//
//  Window.swift
//  XTPopupView
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit

public class Window: UIWindow {
    
    public static let sharedWindow:Window = {
        let window = Window(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = UIViewController()
        window.rootViewController!.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        window.hidden = true
        window.windowLevel = UIWindowLevelStatusBar + 1
        window.makeKeyAndVisible()
        return window
    }()
    
    public func mainView() -> UIView {
        return Window.sharedWindow.rootViewController!.view;
    }
}
