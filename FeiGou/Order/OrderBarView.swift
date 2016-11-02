//
//  OrderBarView.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/2.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class BarCell: UICollectionViewCell {
    
    let lab = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lab.frame = CGRect.init(x: 0, y: 0, width: screenW/5, height: 30)
        lab.textAlignment = .center
        lab.textColor = UIColor.colorFromHex(0x383838)
        lab.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(lab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol OrderBarViewDelegate {
    func didSelectItem(atIndex: Int)
}

class OrderBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    let titleArr = ["全部", "待支付", "进行中", "待评价", "退款单"]
    var delegate: OrderBarViewDelegate?
    
    lazy var barView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: screenW/5, height: 30)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let barView = UICollectionView.init(frame: CGRect.init(x: 0, y: 4, width: screenW, height: 30), collectionViewLayout: layout)
        barView.dataSource = self
        barView.delegate = self
        barView.backgroundColor = .white
        barView.register(BarCell.self, forCellWithReuseIdentifier: "BarCell")
        barView.isPagingEnabled = true
        return barView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.frame.height - 3, width: screenW/5, height: 3))
        view.backgroundColor = UIColor.colorFromHex(0xfd9816)
        return view
    }()
    
    lazy var linebackView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.frame.height - 3, width: screenW, height: 3))
        view.backgroundColor = UIColor.colorFromHex(0xededed)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(barView)
        addSubview(linebackView)
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectItem(atIndex: Int) {
        for index in 0...4 {
            let cell = barView.cellForItem(at: IndexPath.init(row: index, section: 0)) as! BarCell
            cell.lab.textColor = UIColor.colorFromHex(0x383838)
            if index == atIndex {
                cell.lab.textColor = UIColor.colorFromHex(0xfd9816)
            }
        }
    }
    
    //MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        barView.contentOffset = CGPoint.init(x: 0, y: 0)
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.barView.dequeueReusableCell(withReuseIdentifier: "BarCell", for: indexPath) as! BarCell
        cell.lab.text = titleArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(atIndex: indexPath.row)
    }
    
}






