//
//  PopupViewItem.swift
//  XTPopupView
//
//  Created by imchenglibin on 16/2/1.
//  Copyright © 2016年 xt. All rights reserved.
//

import Foundation

public enum PopupViewItemType {
    case Normal, HighLight, Cancel, Disabled
}

public struct PopupViewItem {
    public var title: String
    public var type: PopupViewItemType
}
