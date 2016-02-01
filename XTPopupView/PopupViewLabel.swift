//
//  PopupViewLabel.swift
//  XTPopupView
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit

class PopupViewLabel: UIView {

    var label: UILabel?
    
    init(withUnderline: Bool) {
        super.init(frame: CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
