//
//  OrderDetailController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/2.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var productNum: UILabel!
    @IBOutlet weak var creatTime: UILabel!
    @IBOutlet weak var numberOfProduct: UILabel!
    @IBOutlet weak var price: UILabel!
}

class OrderDetailController: UITableViewController {

    var status = Int() {
        didSet {
            FeiGouApi.shareInstance.getOrderList(status: status) { (model) in
                self.dataModel = model
                self.tableView.reloadData()
            }
        }
    }
    
    var dataModel: OrderListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.colorFromHex(0xededed)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if dataModel != nil {
            return (dataModel.orderList?.count)!
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderCell
        let model = self.dataModel.orderList![indexPath.row]
        cell.img.kf_setImage(with: URL.init(string: model.picPath!))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.colorFromHex(0xededed)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        }
        return 8
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
