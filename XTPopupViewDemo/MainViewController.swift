//
//  ViewController.swift
//  XTPopupView
//
//  Created by imchenglibin on 16/1/29.
//  Copyright © 2016年 xt. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "XTPopupView"
        
        let button = UIButton(type: UIButtonType.ContactAdd)
        self.view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        button.addTarget(self, action: Selector("click:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func click(sender: UIButton) {
        let sheet = ActionSheet(title: "选择照片选择照片选择照片选择照片", items: [ActionItem(title: "相机", type: .Normal), ActionItem(title: "相册", type: .HighLight), ActionItem(title: "其他", type: .Disabled)], block: {(Int index)->Void in
            print(index)
        })
        sheet.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

