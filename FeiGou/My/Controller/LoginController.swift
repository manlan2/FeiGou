//
//  LoginController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/10/31.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class LoginCell: UITableViewCell {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var forgetPassWord: UIButton!
    @IBOutlet weak var register: UIButton!
}

class LoginController: BaseTableViewController {
    
    var userName: UITextField!
    var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login() {
        FeiGouApi.shareInstance.loginApp(userName: self.userName.text!, passWord: self.passWord.text!) { (userModel) in
            if userModel.msg == "success" {
                //登录成功
                UserManager.login(name: userModel.mobilePhone, psd: self.passWord.text!, userId: userModel.userId)
                _ = self.navigationController?.popViewController(animated: true)
            } else {
                //登录失败
                UserManager.exit()
            }
        }
    }
    
    func register() {
        
    }
    
    func forgetPassWord() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginCell
        self.userName = cell.userName
        self.passWord = cell.passWord
        cell.login.addTarget(self, action: #selector(login), for: .touchUpInside)
        cell.register.addTarget(self, action: #selector(register), for: .touchUpInside)
        cell.forgetPassWord.addTarget(self, action: #selector(forgetPassWord), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

}







