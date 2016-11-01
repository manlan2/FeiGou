//
//  BaseTableViewController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/1.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit
import Foundation

class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 60))
        btn.setImage(UIImage.init(named: "back"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
        btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        let backBar = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = backBar
    }
    
    func backClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
