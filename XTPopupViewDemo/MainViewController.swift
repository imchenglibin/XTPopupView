//
//  ViewController.swift
//  XTPopupView
//
//  Created by imchenglibin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var _tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "XTPopupView"
        
        _tableView = UITableView()
        
        self.view.addSubview(_tableView!)
        
        _tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        _tableView!.dataSource = self
        _tableView!.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _tableView!.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let items = ["Action Sheet", "Alert View", "Alert View Input"]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = items[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let sheet = ActionSheet(title: "选择照片", items: [PopupViewItem(title: "相机", type: .Normal), PopupViewItem(title: "相册", type: .Normal)], block: {(Int index)->Void in
                print(index)
            })
            sheet.show()
        } else if indexPath.row == 1 {
            let alert = AlertView(title: "提示框", message: "这是一个选择题", items: [PopupViewItem(title: "选择A", type: .Normal), PopupViewItem(title: "选择B", type: .Normal), PopupViewItem(title: "选择C", type: .Normal)], action: { (Int index) -> Void in
                print(index)
            })
            alert.messageAlignment = NSTextAlignment.Left
            alert.show()
        } else if indexPath.row == 2 {
            let alert = AlertView(title: "这是一个输入框", placeholder: "消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息", inputTextFieldHandler: { (textField) -> Void in
                
                }, items: [PopupViewItem(title: "确定", type: .Normal), PopupViewItem(title: "取消", type: .HighLight), ], action: { (Int index) -> Void in
                    print(index)
            })
            alert.show()
        }
    }
}

