//
//  MyTableViewController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/10/29.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
}

class MyTableViewController: UITableViewController {

    let imgArr = ["address", "message", "evaluate", "member_card", "collect", "password_setting", "set"]
    let titleArr = ["我的收货地址", "我的消息", "我的评价", "会员卡", "我的收藏", "密码设置", "设置"]

    var userName: UILabel!
    var userImg : UIImageView!
    var isLogin : Bool?
    
    lazy var headView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 185))
        view.backgroundColor = UIColor.colorFromHex(0x989898)
        
        let stateView = UIView.init(frame: CGRect.init(x: 0, y: -20, width: screenW, height: 20))
        stateView.backgroundColor = UIColor.colorFromHex(0x989898)
        view.addSubview(stateView)
        
        self.userImg = UIImageView.init(frame: CGRect.init(x: screenW/2 - 49, y: 185/2 - 49, width: 98, height: 98))
        self.userImg.kf_setImage(with: URL.init(string: "https://source.unsplash.com/random/320x320"))
        self.userImg.layer.masksToBounds = true
        self.userImg.layer.cornerRadius = 49
        view.addSubview(self.userImg)
        
        self.userName = UILabel.init(frame: CGRect.init(x: 20, y: 185/2 + 49 + 5, width: screenW - 40, height: 28))
        self.userName.textAlignment = .center
        self.userName.textColor = UIColor.colorFromHex(0x383838)
        self.userName.text = "立即登录"
        if self.isLogin! {
            self.userName.text = UserManager.getUserName()
        }
        self.userName.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(self.userName)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(pushLogin))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLogin = UserManager.isLogin()
//        self.clearsSelectionOnViewWillAppear = true
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.tableHeaderView = headView
        NotificationCenter.default.addObserver(self, selector: #selector(login), name: NSNotification.Name(rawValue: "isLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(exit), name: NSNotification.Name(rawValue: "exit"), object: nil)
    }
    
    func login() {
        self.isLogin = true
        self.userName.text = UserManager.getUserName()
    }
    
    func exit() {
        self.isLogin = false
        self.userName.text = "立即登录"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pushLogin() {
        if !self.isLogin! {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginController")
            loginVC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(loginVC!, animated: true)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.img.image = UIImage.init(named: imgArr[indexPath.row])
        cell.title.text = titleArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 6:
            let svc = self.storyboard?.instantiateViewController(withIdentifier: "SetController")
            svc?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(svc!, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}




















