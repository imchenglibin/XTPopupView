//
//  ActionItem.swift
//  XTPopupView
//
//  Created by imchenlibin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import Foundation

public enum ActionItemType {
    case Normal, HighLight, Disabled, Cancel
}

public struct ActionItem {
    public var title: String
    public var type: ActionItemType
}
