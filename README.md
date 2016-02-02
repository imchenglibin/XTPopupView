# XTPopupView
A popup view for iOS in swift

## Overview
<image height=500 src="https://github.com/imchenglibin/XTPopupView/blob/master/Images/intro0.png">
<image height=500 src="https://github.com/imchenglibin/XTPopupView/blob/master/Images/intro1.png">
<image height=500 src="https://github.com/imchenglibin/XTPopupView/blob/master/Images/intro2.png">

## Usage

```swift
let sheet = ActionSheet(title: "选择照片", items: [PopupViewItem(title: "相机", type: .Normal), PopupViewItem(title: "相册", type: .Normal)], block: {(Int index)->Void in
                //to do something
            })
sheet.show()

let alert = AlertView(title: "提示框", message: "这是一个选择题", items: [PopupViewItem(title: "选择A", type: .Normal), PopupViewItem(title: "选择B", type: .Normal), PopupViewItem(title: "选择C", type: .Normal)], action: { (Int index) -> Void in
                //to do something
            })
alert.messageAlignment = NSTextAlignment.Left
alert.show()

let alert = AlertView(title: "这是一个输入框", placeholder: "消息", inputTextFieldHandler: { (textField) -> Void in
                
                }, items: [PopupViewItem(title: "确定", type: .Normal), PopupViewItem(title: "取消", type: .HighLight), ], action: { (Int index) -> Void in
                    //to do something
            })
alert.show()

```
For more detail refer to the demo in this project

## License
This project use `MIT` license, for more details refer to `LICENSE` file
