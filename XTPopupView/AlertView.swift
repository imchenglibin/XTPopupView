//
//  AlertView.swift
//  XTPopupView
//
//  Created by imchenglibin on 16/2/1.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

public class AlertView: PopupView {
    private var _textFieldHandler: ((textField: UITextField)->Void)?
    private var _block:(Int)->Void
    private static let DefaultItemHeight: CGFloat = 40
    private var _messageLabel: UILabel?
    private var _totalHeight: CGFloat = 0

    public var inputTextField: UITextField?
    
    public var messageAlignment: NSTextAlignment? {
        get {
            return _messageLabel?.textAlignment
        }
        set {
            _messageLabel?.textAlignment = newValue!
        }
    }
    
    public init(title: String, message: String, items: [PopupViewItem], action: (Int)->Void) {
        _block = action
        super.init(frame: CGRectZero)
        alertView(title, message: message, items: items)
    }
    
    private func alertView(title: String, message: String, items: [PopupViewItem]) {
        let alertViewContainer = UIView()
        alertViewContainer.layer.cornerRadius = 10
        alertViewContainer.clipsToBounds = true
        alertViewContainer.backgroundColor = UIColor.groupTableViewBackgroundColor()
        let titleLabel = UILabel.xt_label(title)
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        alertViewContainer.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(alertViewContainer)
            make.top.equalTo(alertViewContainer)
            make.right.equalTo(alertViewContainer)
            make.height.equalTo(AlertView.DefaultItemHeight)
        }
        _totalHeight += AlertView.DefaultItemHeight
        var preView: UIView = titleLabel
        
        if let _ = _textFieldHandler {
            let textFieldContainer = UIView()
            textFieldContainer.backgroundColor = UIColor.whiteColor()
            let textField = UITextField()
            inputTextField = textField
            textField.font = UIFont.systemFontOfSize(14)
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textFieldContainer.addSubview(textField)
            textField.placeholder = message
            _textFieldHandler!(textField: textField)
            textField.becomeFirstResponder()
            textField.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(textFieldContainer)
                make.left.equalTo(textFieldContainer).offset(8)
                make.right.equalTo(textFieldContainer).offset(-8)
                make.height.equalTo(AlertView.DefaultItemHeight)
            }
            alertViewContainer.addSubview(textFieldContainer)
            textFieldContainer.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(preView.snp_bottom)
                make.left.equalTo(alertViewContainer)
                make.right.equalTo(alertViewContainer)
                make.height.equalTo(AlertView.DefaultItemHeight + 5)
            })
            
            preView = textFieldContainer
            _totalHeight += AlertView.DefaultItemHeight + 5
            
        } else {
            let messageLabel = UILabel.xt_label(message)
            messageLabel.font = UIFont.systemFontOfSize(12)
            alertViewContainer.addSubview(messageLabel)
            messageLabel.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(alertViewContainer)
                make.top.equalTo(preView.snp_bottom)
                make.right.equalTo(alertViewContainer)
                make.height.equalTo(AlertView.DefaultItemHeight)
            }
            preView = messageLabel
            _totalHeight += AlertView.DefaultItemHeight
        }
        
        if items.count == 2 {
            let btn0 = UIButton.xt_button(items[0].title, type: items[0].type)
            let btn1 = UIButton.xt_button(items[1].title, type: items[1].type)
            alertViewContainer.addSubview(btn0)
            alertViewContainer.addSubview(btn1)
            
            btn0.tag = 0
            if items[0].type != .Disabled {
                btn0.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            }
            btn1.tag = 1
            if items[1].type != .Disabled {
                btn1.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            }
            btn0.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(alertViewContainer)
                make.right.equalTo(btn1.snp_left).offset(-1)
                make.top.equalTo(preView.snp_bottom).offset(1)
                make.height.equalTo(AlertView.DefaultItemHeight)
                make.width.equalTo(btn1)
            })
            btn1.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(alertViewContainer)
                make.top.equalTo(preView.snp_bottom).offset(1)
                make.height.equalTo(AlertView.DefaultItemHeight)
            })
            _totalHeight += AlertView.DefaultItemHeight
        } else {
            for var i=0; i<items.count; i++ {
                let item = items[i]
                let btn = UIButton.xt_button(item.title, type: item.type)
                btn.tag = i
                if item.type != .Disabled {
                    btn.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
                }
                alertViewContainer.addSubview(btn)
                btn.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.equalTo(alertViewContainer)
                    make.right.equalTo(alertViewContainer)
                    make.top.equalTo(preView.snp_bottom).offset(1)
                    make.height.equalTo(AlertView.DefaultItemHeight)
                })
                _totalHeight += AlertView.DefaultItemHeight
                preView = btn
            }
        }
        let minSize = min(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        addSubview(alertViewContainer)
        
        if let _ = _textFieldHandler {
            alertViewContainer.snp_makeConstraints { (make) -> Void in
                make.center.equalTo(self).offset(CGPoint(x: 0, y: -216 / 2))
                make.width.equalTo(minSize - 40)
                make.height.equalTo(_totalHeight)
            }
        } else {
            alertViewContainer.snp_makeConstraints { (make) -> Void in
                make.center.equalTo(self)
                make.width.equalTo(minSize - 40)
                make.height.equalTo(_totalHeight)
            }
        }
    }
    
    func buttonAction(sender: UIButton) {
        _block(sender.tag)
        self.hide()
    }
    
    public init(title: String, placeholder: String, inputTextFieldHandler: (textField: UITextField )->Void, items: [PopupViewItem], action: (Int)->Void) {
        _block = action
        _textFieldHandler = inputTextFieldHandler
        super.init(frame: CGRectZero)
        alertView(title, message: placeholder, items: items)
    }
    
    func itemAction(sender: UIButton) {
        _block(sender.tag)
        
        inputTextField?.resignFirstResponder()
        
        self.hide()
    }
    
    public override func show() {
        super.show()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
