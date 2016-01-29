//
//  ActionItem.swift
//  XTPopupView
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import Foundation

public enum ActionItemType {
    case Normal, HighLight, Disabled
}

public struct ActionItem {
    public var title: String
    public var type: ActionItemType
}
