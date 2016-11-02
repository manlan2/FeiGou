//
//  OrderController.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/2.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class OrderController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, OrderBarViewDelegate {

    var barView = OrderBarView()
    var views = [UIView]()
    
    lazy var collectView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: screenW, height: screenH - 154)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView.init(frame: CGRect.init(x: 0, y: 104, width: screenW, height: screenH - 154), collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单"
        self.automaticallyAdjustsScrollViewInsets = false // 超级坑
        barView = OrderBarView.init(frame: CGRect.init(x: 0, y: 64, width: screenW, height: 40))
        barView.delegate = self
        self.view.addSubview(barView)
        
        for i in 0...4 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailController") as! OrderDetailController
            vc.status = i
            self.addChildViewController(vc)
            vc.view.frame = CGRect.init(x: 0, y: 0, width: screenW, height: screenH - 154)
            vc.didMove(toParentViewController: self)
            views.append(vc.view)
        }
        self.view.addSubview(collectView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.addSubview(views[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = Int(round(scrollView.contentOffset.x / self.view.bounds.width))
        self.barView.lineView.frame.origin.x = (scrollView.contentOffset.x / 5)
        self.barView.selectItem(atIndex: scrollIndex)
    }
    
    func didSelectItem(atIndex: Int) {
        collectView.scrollRectToVisible(CGRect.init(origin: CGPoint.init(x: (self.view.bounds.width * CGFloat(atIndex)), y: 0), size: self.view.bounds.size), animated: true)
    }
    
}





