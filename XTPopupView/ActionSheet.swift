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
    private var _block:(Int)->Void
    private static let DefaultItemHeight: CGFloat = 40
    private static let SeparateLineHeight: CGFloat = 10
    private var _actionSheetContainer: UIView?
    private var _totalHeight: CGFloat = 0
    private var _titleLabelHeight: CGFloat = 0
    
    public init(title: String, items:[PopupViewItem], block:(Int)->Void) {
        _block = block
        super.init(frame: CGRectZero)
        actionSheet(title, items: items, block: block)
    }
    
    private func actionSheet(title: String, items: [PopupViewItem], block:(Int)->Void) {
        _actionSheetContainer = UIView()
        _actionSheetContainer!.backgroundColor = UIColor.groupTableViewBackgroundColor()
        let label = UILabel.xt_label(title)
        label.font = UIFont.systemFontOfSize(12)
        _actionSheetContainer!.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(_actionSheetContainer!)
            make.left.equalTo(_actionSheetContainer!)
            make.right.equalTo(_actionSheetContainer!)
            make.height.equalTo(ActionSheet.DefaultItemHeight)
        }
        _titleLabelHeight = ActionSheet.DefaultItemHeight
        var preView: UIView = label
        _totalHeight += ActionSheet.DefaultItemHeight
        
        for var i=0; i<items.count; i++ {
            let item = items[i]
            let btn = UIButton.xt_button(item.title, type: item.type)
            btn.tag = i
            if item.type != .Disabled {
                btn.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            }
            _actionSheetContainer!.addSubview(btn)
            btn.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(_actionSheetContainer!)
                make.right.equalTo(_actionSheetContainer!)
                make.top.equalTo(preView.snp_bottom).offset(1)
                make.height.equalTo(ActionSheet.DefaultItemHeight)
            })
            
            _totalHeight += ActionSheet.DefaultItemHeight
            preView = btn
        }

        let btn = UIButton.xt_button("取消", type: .Normal)
        btn.tag = items.count
        btn.addTarget(self, action: Selector("dismissPopup:"), forControlEvents: UIControlEvents.TouchUpInside)
        _actionSheetContainer!.addSubview(btn)
        btn.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(_actionSheetContainer!)
            make.right.equalTo(_actionSheetContainer!)
            make.top.equalTo(preView.snp_bottom).offset(9)
            make.height.equalTo(ActionSheet.DefaultItemHeight)
        })
        
        _totalHeight += ActionSheet.DefaultItemHeight + ActionSheet.SeparateLineHeight
        preView = btn
        
        addSubview(_actionSheetContainer!)
        _actionSheetContainer!.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(_totalHeight)
        }
    }
    
    override public func animationWhenShow(complete: () -> Void) {
        _actionSheetContainer?.layer.position = CGPoint(x: self.attachView.bounds.size.width / 2, y: self.attachView.bounds.size.height + _totalHeight / 2)
        UIView.animateWithDuration(0.25, animations: { [unowned self]() -> Void in
            self._actionSheetContainer?.layer.position = CGPoint(x: self.attachView.bounds.size.width / 2, y: self.attachView.bounds.size.height - self._totalHeight / 2)
            }) { (Bool) -> Void in
            complete()
        }
    }
    
    override public func animationWhenHide(complete: () -> Void) {
        UIView.animateWithDuration(0.25, animations: { [unowned self]() -> Void in
            self._actionSheetContainer?.layer.position = CGPoint(x: self.attachView.bounds.size.width / 2, y: self.attachView.bounds.size.height + self._totalHeight / 2)
            }) { (Bool) -> Void in
                complete()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let label = _actionSheetContainer?.subviews.first as! UILabel

        let actualSize = label.sizeThatFits(CGSize(width:UIScreen.mainScreen().bounds.size.width - 16, height: 0))
        
        var titleHeight = actualSize.height
        
        if titleHeight < ActionSheet.DefaultItemHeight {
            titleHeight = ActionSheet.DefaultItemHeight
        } else {
            titleHeight += 16
        }
        
        label.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(titleHeight)
        }
        
        _actionSheetContainer?.snp_updateConstraints(closure: { [unowned self](make) -> Void in
            make.height.equalTo(self._totalHeight - self._titleLabelHeight + titleHeight)
        })
        
        _totalHeight = _totalHeight - _titleLabelHeight + titleHeight
        _titleLabelHeight = titleHeight
    }
    
    func buttonAction(sender: UIButton) {
        _block(sender.tag)
        self.hide()
    }
    
    func dismissPopup(sender: UIButton) {
        self.hide()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
