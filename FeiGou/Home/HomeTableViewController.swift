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
    let listName = ["苹果苹果苹果苹果苹果苹果苹果苹果苹果苹果", "香蕉香蕉香蕉香蕉香蕉香蕉香蕉", "栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子", "哈密瓜哈密瓜哈密瓜哈密瓜", "苹果苹果苹果苹果苹蕉香蕉", "香蕉香蕉香蕉香蕉香蕉香蕉香蕉", "栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子", "栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子", "栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子栗子", "果苹果苹果苹果苹蕉香蕉子栗子栗子栗子栗子栗子栗子栗子"]
    let listPrice = [12,321,3123,21,31,3,32,3,11,65]
    
    lazy var categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: screenW / 5, height: screenW / 5 + 10)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cview = UICollectionView.init(frame: CGRect.init(x: 0, y: screenW / 2.35, width: screenW, height: screenW / 5 * 2 + 20), collectionViewLayout: layout)
        cview.delegate = self
        cview.dataSource = self
        cview.isScrollEnabled = false
        cview.backgroundColor = UIColor.clear
//        cview.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        cview.register(UINib.init(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        return cview
    }()
    
    lazy var headView: UIView = {
        let bannerArr = ["http://120.24.3.172:8080/feigou-api/api/upload/images/index/banner/home_banner1.png",
                         "http://120.24.3.172:8080/feigou-api/api/upload/images/index/banner/home_banner2.png",
                         "http://120.24.3.172:8080/feigou-api/api/upload/images/index/banner/home_banner3.png",]
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenW / 2.35 + screenW / 5 * 2 + 20))
        let bannerView = BannerView.creatBanner(frame: CGRect.init(x: 0, y: 0, width: screenW, height: screenW / 2.35), imgUrlArr: bannerArr, delegate: self)
        view.addSubview(bannerView)
        view.addSubview(self.categoryView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "homelogo"))
        self.tableView.tableHeaderView = self.headView
        
        FeiGouApi.shareInstance.getHomeList(pageNum: 0, pageSize: 3) { (respondModel) in
            self.listData = respondModel
            self.tableView.reloadData()
        }
        FeiGouApi.shareInstance.getHomeCategory { (respondModel) in
            self.categoryArr = respondModel.categoryList
            self.categoryView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - banner delegate
    
    func didSelectImg(atIndex: Int) {
        print(atIndex)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if listData != nil {
//            return listData!.productList!.count
            return 10
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homelistcell", for: indexPath) as! HomeListCell
//        let model: productListModel = listData!.productList![indexPath.row]
        cell.title.text = listName[indexPath.row]
        cell.state.text = "接受预订"
        cell.price.text = "P\(listPrice[indexPath.row])"
        cell.img.kf_setImage(with: URL.init(string: "https://source.unsplash.com/random/300x(\(200+indexPath.row))"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 8))
        view.backgroundColor = UIColor.colorFromHex(0xededed)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    // MARK: - collect view data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.categoryView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        if self.categoryArr != nil {
            let model: categoryListModel = (self.categoryArr?[indexPath.row])!
            cell.title.text = model.name
            cell.img.kf_setImage(with: URL.init(string: (model.icon)!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

