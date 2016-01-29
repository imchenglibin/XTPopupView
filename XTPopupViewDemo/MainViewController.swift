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
        // Do any additional setup after loading the view, typically from a nib.
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
        return 2;
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let items = ["Action Sheet", "Alert View"]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = items[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let sheet = ActionSheet(title: "选择照片选择照片选择照片选择照片", items: [ActionItem(title: "相机", type: .Normal), ActionItem(title: "相册", type: .HighLight), ActionItem(title: "其他", type: .Disabled)], block: {(Int index)->Void in
                print(index)
            })
            sheet.show()
        }
    }
}

