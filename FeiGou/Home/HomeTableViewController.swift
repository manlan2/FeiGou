//
//  HomeTableViewController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/10/27.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit
import Kingfisher

class HomeListCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var price: UILabel!
}

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!

}

class HomeTableViewController: UITableViewController , BannerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var listData: ProductModel?
    var categoryArr: [categoryListModel]?
    
    lazy var categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: (screenW - 100) / 5, height: (screenW - 100) / 5 + 30)
        let cview = UICollectionView.init(frame: CGRect.init(x: 0, y: screenW / 2.35, width: screenW, height: screenW / 2.35), collectionViewLayout: layout)
        cview.delegate = self
        cview.dataSource = self
        cview.isScrollEnabled = false
        cview.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return cview
    }()
    
    lazy var headView: UIView = {
        let bannerArr = ["http://120.24.3.172:8080/feigou-api/api/upload/images/index/banner/home_banner1.png",
                         "http://120.24.3.172:8080/feigou-api/api/upload/images/index/banner/home_banner2.png",
                         "http://120.24.3.172:8080/feigou-api/api/upload/images/index/banner/home_banner3.png",]
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenW / 2.35 + ((screenW - 100) / 5 + 30) * 2.5))
        let bannerView = BannerView.creatBanner(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenW / 2.35), imgUrlArr: bannerArr, delegate: self)
        view.addSubview(bannerView)
        view.addSubview(self.categoryView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableHeaderView = self.headView
        
        FeiGouApi.shareInstance.getHomeList(pageNum: 0, pageSize: 3) { (respondModel) in
            self.listData = respondModel
            self.tableView.reloadData()
        }
        FeiGouApi.shareInstance.getHomeCategory { (respondModel) in
            self.categoryArr = respondModel.categoryList
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK banner delegate
    
    func didSelectImg(atIndex: Int) {
        print(atIndex)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if listData != nil {
            return listData!.productList!.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homelistcell", for: indexPath) as! HomeListCell
        let model: productListModel = listData!.productList![indexPath.row]
        cell.title.text = model.name!
        cell.price.text = "P\(model.price!)"
        cell.img.kf_setImage(with: URL.init(string: model.picPath!))
        return cell
    }
    
    // MARK: - collect view data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.categoryView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let model = self.categoryArr?[indexPath.row]
//        cell.title.text = model?.name
//        cell.img.kf_setImage(with: URL.init(string: (model?.icon)!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

