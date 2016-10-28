//
//  BannerView.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/10/28.
//  Copyright © 2016年 like. All rights reserved.
//

protocol BannerViewDelegate {
    func didSelectImg(atIndex: Int)
}

import UIKit

class BannerView: UIScrollView {
    
    var imgDelegate: BannerViewDelegate?
    
    var imgUrlArr: [String]! {
        didSet {
            for i in 0..<imgUrlArr.count {
                let iv = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * frame.width, y: 0, width: frame.width, height: frame.height))
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.selesctImg))
                iv.addGestureRecognizer(tap)
                iv.isUserInteractionEnabled = true
                iv.kf_setImage(with: URL.init(string: imgUrlArr[i]))
                iv.tag = 200 + i
                self.addSubview(iv)
            }
        }
    }
    
    class func creatBanner(frame: CGRect, imgUrlArr: [String], delegate: BannerViewDelegate?) -> BannerView {
        let bannerView = BannerView.init(frame: frame)
        bannerView.imgUrlArr = imgUrlArr
        bannerView.imgDelegate = delegate
        bannerView.isPagingEnabled = true
        bannerView.showsHorizontalScrollIndicator = false
        bannerView.contentSize = CGSize.init(width: frame.width * CGFloat(imgUrlArr.count), height: frame.height)
        return bannerView
    }
    
    func selesctImg(tap: UITapGestureRecognizer) {
        imgDelegate?.didSelectImg(atIndex: (tap.view?.tag)! - 200)
    }
}
