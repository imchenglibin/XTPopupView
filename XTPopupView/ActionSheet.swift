//
//  ActionSheet.swift
//  XTPopupView
//
//  Created by imchenlibin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

public class ActionSheet: PopupView {
    private var _title: String
    private var _items: [ActionItem]
    private var _block:(Int)->Void
    private static let DefaultItemHeight: CGFloat = 40
    
    public init(title: String, items:[ActionItem], block:(Int)->Void) {
        _title = title
        _items = items
        _block = block
        super.init(frame: CGRectZero)
        super.setCustomView(createActionSheetView(), position: .Bottom)
    }
    
    override public func setCustomView(customView: UIView, position: PopupViewCustomViewPosition) {
        fatalError("Custom view is not allowed")
    }
    
    private func createActionSheetView() -> UIView {
        let container = UIView()
        var height: CGFloat = 0.0
        var preItemView: UIView?
        
        let titleContainer = UIView()
        titleContainer.backgroundColor = UIColor.whiteColor()
        let titleLabel = UILabel()
        titleLabel.text = _title
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = UIColor.darkGrayColor()
        titleLabel.font = UIFont.systemFontOfSize(12)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleContainer.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleContainer).offset(8)
            make.right.equalTo(titleContainer).offset(-8)
            make.top.equalTo(titleContainer)
            make.bottom.equalTo(titleContainer)
        }
        container.addSubview(titleContainer)
        
        titleContainer.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(container)
            make.right.equalTo(container)
            make.top.equalTo(container)
            make.height.equalTo(ActionSheet.DefaultItemHeight)
        }
        
        preItemView = titleContainer
        
        let underlineView = UIView()
        underlineView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        container.addSubview(underlineView)
        underlineView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(container)
            make.right.equalTo(container)
            make.top.equalTo(preItemView!.snp_bottom)
            make.height.equalTo(1)
        }
        
        preItemView = underlineView
        
        height = ActionSheet.DefaultItemHeight + 1
        
        for var i=0; i<_items.count; i++ {
            let item = _items[i]
            var underlineHeight: CGFloat = 1.0
            if i == _items.count - 1 {
                underlineHeight = 10.0
            }
            let itemView = ActionItemView(title: item.title, underlineHeight: underlineHeight, type: item.type)
            itemView.addTarget(self, action: Selector("itemAction:"), forControlEvents: UIControlEvents.TouchUpInside, tag: i)
            container.addSubview(itemView)
            if let preView = preItemView {
                itemView.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.equalTo(container)
                    make.right.equalTo(container)
                    make.top.equalTo(preView.snp_bottom)
                    make.height.equalTo(ActionSheet.DefaultItemHeight + underlineHeight)
                })
            }
            height += ActionSheet.DefaultItemHeight + underlineHeight
            preItemView = itemView
        }
        
        let itemView = ActionItemView(title: "取消", underlineHeight: 0, type: .Normal)
        itemView.addTarget(self, action: Selector("itemAction:"), forControlEvents: UIControlEvents.TouchUpInside, tag: _items.count)
        container.addSubview(itemView)
        if let preView = preItemView {
            itemView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(container)
                make.right.equalTo(container)
                make.top.equalTo(preView.snp_bottom)
                make.height.equalTo(ActionSheet.DefaultItemHeight)
            })
        }
        height += ActionSheet.DefaultItemHeight
        
        container.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        
        return container
    }
    
    func itemAction(sender: UIButton) {
        if sender.tag < _items.count && _items[sender.tag].type == ActionItemType.Disabled {
            return
        }
        if sender.tag < _items.count {
            _block(sender.tag)
        }
        self.hide()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
