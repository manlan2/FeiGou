//
//  SetController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/1.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

class SetController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func exit() {
        UserManager.exit()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SetCell") as! SetCell
        cell.title.text = "意见反馈"
        if indexPath.row == 1 {
            cell.title.text = "关于我们"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 100))
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 20, y: 10, width: screenW - 40, height: 44)
        btn.backgroundColor = UIColor.colorFromHex(0xFF9200)
        btn.setTitle("退出登录", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(exit), for: .touchUpInside)
        view.addSubview(btn)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
