//
//  AlertView.swift
//  XTPopupView
//
//  Created by admin on 16/2/1.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

public class AlertView: PopupView {
    private var _title: String
    private var _message: String
    private var _items: [ActionItem]
    private var _textFieldHandler: ((textField: UITextField)->Void)?
    private var _block:(Int)->Void
    private static let DefaultItemHeight: CGFloat = 40
    private var _messageLabel: UILabel?

    public var inputTextField: UITextField?
    
    public var messageAlignment: NSTextAlignment? {
        get {
            return _messageLabel?.textAlignment
        }
        set {
            _messageLabel?.textAlignment = newValue!
        }
    }
    
    public init(title: String, message: String, items: [ActionItem], action: (Int)->Void) {
        _title = title
        _message = message
        _items = items
        _block = action
        super.init(frame: CGRectZero)
        super.setCustomView(createAlertView(), position: .Center)
    }
    
    public init(title: String, placeholder: String, inputTextFieldHandler: (textField: UITextField )->Void, items: [ActionItem], action: (Int)->Void) {
        _title = title
        _items = items
        _block = action
        _message = placeholder
        _textFieldHandler = inputTextFieldHandler
        super.init(frame: CGRectZero)
        super.setCustomView(createAlertView(), position: .Center)
    }
    
    private func createAlertView() -> UIView {
        let minSize = min(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height) - 40
        let alertView = UIView(frame: CGRectZero)
        alertView.layer.cornerRadius = 10
        alertView.clipsToBounds = true
        alertView.backgroundColor = UIColor.whiteColor()
        var preItemView: UIView?
        var height: CGFloat = 0
        
        let titleLabel = UILabel()
        titleLabel.text = _title
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.textAlignment = NSTextAlignment.Center
        alertView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(alertView)
            make.left.equalTo(alertView)
            make.right.equalTo(alertView)
            make.height.equalTo(AlertView.DefaultItemHeight)
        }
        height += AlertView.DefaultItemHeight
        preItemView = titleLabel
        
        if let textFieldHandler = _textFieldHandler {
            let textField = UITextField()
            inputTextField = textField
            textField.becomeFirstResponder()
            textField.font = UIFont.systemFontOfSize(14)
            textField.borderStyle = UITextBorderStyle.RoundedRect
            alertView.addSubview(textField)
            textField.placeholder = _message
            textFieldHandler(textField: textField)
            textField.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(preItemView!.snp_bottom)
                make.left.equalTo(alertView).offset(8)
                make.right.equalTo(alertView).offset(-8)
                make.height.equalTo(AlertView.DefaultItemHeight)
            }
            preItemView = textField
            height += AlertView.DefaultItemHeight
        } else {
            let messageLabel = UILabel()
            _messageLabel = messageLabel
            messageLabel.text = _message
            messageLabel.textColor = UIColor.darkGrayColor()
            messageLabel.font = UIFont.systemFontOfSize(12)
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.numberOfLines = 0
            alertView.addSubview(messageLabel)
            let fitSize = messageLabel.sizeThatFits(CGSize(width: minSize - 16, height: 0))
            
            messageLabel.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(preItemView!.snp_bottom)
                make.left.equalTo(alertView).offset(8)
                make.right.equalTo(alertView).offset(-8)
                make.height.equalTo(fitSize.height)
            }
            
            preItemView = messageLabel
            height += fitSize.height
        }
        
        let underline = UIView()
        underline.backgroundColor = UIColor.groupTableViewBackgroundColor()
        alertView.addSubview(underline)
        underline.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(alertView)
            make.right.equalTo(alertView)
            make.top.equalTo(preItemView!.snp_bottom).offset(4)
            make.height.equalTo(1)
        }
        
        preItemView = underline
        height += 5
        
        if _items.count == 2 {
            let itemView0 = ActionItemView(title: _items[0].title, underlineHeight: 0, type: _items[0].type)
            let itemView1 = ActionItemView(title: _items[1].title, underlineHeight: 0, type: _items[1].type)
            itemView0.addTarget(self, action: Selector("itemAction:"), forControlEvents: UIControlEvents.TouchUpInside, tag: 0)
            itemView1.addTarget(self, action: Selector("itemAction:"), forControlEvents: UIControlEvents.TouchUpInside, tag: 1)
            alertView.addSubview(itemView0)
            alertView.addSubview(itemView1)
            
            let separateLine = UIView()
            separateLine.backgroundColor = UIColor.groupTableViewBackgroundColor()
            alertView.addSubview(separateLine)
            
            itemView0.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(alertView)
                make.right.equalTo(separateLine.snp_left)
                make.width.equalTo(itemView1)
                make.bottom.equalTo(alertView)
                make.height.equalTo(AlertView.DefaultItemHeight)
            })
            
            separateLine.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(itemView0.snp_centerY)
                make.bottom.equalTo(alertView)
                make.top.equalTo(itemView0.snp_top)
                make.width.equalTo(1)
            })
            
            itemView1.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(separateLine.snp_right)
                make.right.equalTo(alertView)
                make.bottom.equalTo(alertView)
                make.height.equalTo(AlertView.DefaultItemHeight)
            })
            
            height += AlertView.DefaultItemHeight
        } else {
            var underlineHeight: CGFloat = 1.0
            for var i=0; i<_items.count; i++ {
                let item = _items[i]
                if i == _items.count - 1 {
                    underlineHeight = 0
                }
                let itemView = ActionItemView(title: item.title, underlineHeight: underlineHeight, type: item.type)
                itemView.addTarget(self, action: Selector("itemAction:"), forControlEvents: UIControlEvents.TouchUpInside, tag: i)
                alertView.addSubview(itemView)
                
                if let preView = preItemView {
                    itemView.snp_makeConstraints(closure: { (make) -> Void in
                        make.left.equalTo(alertView)
                        make.right.equalTo(alertView)
                        make.top.equalTo(preView.snp_bottom)
                        make.height.equalTo(AlertView.DefaultItemHeight + underlineHeight)
                    })
                } else {
                    itemView.snp_makeConstraints(closure: { (make) -> Void in
                        make.left.equalTo(alertView)
                        make.right.equalTo(alertView)
                        make.top.equalTo(alertView)
                        make.height.equalTo(AlertView.DefaultItemHeight + underlineHeight)
                    })
                }
                preItemView = itemView
                height += AlertView.DefaultItemHeight + underlineHeight
            }
        }
        
        alertView.frame = CGRect(x: 0, y: 0, width: minSize, height: height)
        
        return alertView
    }
    
    func itemAction(sender: UIButton) {
        if _items[sender.tag].type == ActionItemType.Disabled {
            return
        }
        if sender.tag < _items.count {
            _block(sender.tag)
        }
        
        inputTextField?.resignFirstResponder()
        
        self.hide()
    }
    
    public override func show() {
        super.show()
        if let _ = inputTextField {
            self.customView?.snp_updateConstraints(closure: { (make) -> Void in
                let newPoint = CGPoint(x: self.center.x, y: self.center.y - 216 / 2)
                make.center.equalTo(self).offset(newPoint)
            })
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
