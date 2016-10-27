//
//  HomeModel.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/10/27.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit

class HomeModel: NSObject {

}

struct ProductModel: HandyJSON{
    var page: [String: AnyObject]?
    var productList: [productListModel]?
}

struct productListModel: HandyJSON{
    var bussinesId: Int?
    var categoryId: Int?
    var createTime: Int64?
    var discountPrice: Int?
    var expressPrice: Int?
    var name:String?
    var picPath:String?
    var price: Int?
    var productCode:String?
    var productDescribe:String?
    var productId: Int?
    var saleNum: Int64?
    var status: Int?
    var stockNum: Int?
    var updateTime: Int64?
}