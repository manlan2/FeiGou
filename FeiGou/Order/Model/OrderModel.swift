//
//  OrderModel.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/2.
//  Copyright © 2016年 like. All rights reserved.
//

//\"orderList\":[{\"productId\":35,\"orderId\":66,\"orderName\":\"Apple\",\"orderCode\":\"D14762381787770004\",\"createTime\":1476238178000,\"expressPrice\":0,\"productPrice\":100.0,\"productNum\":4.0,\"productTotal\":400.0,\"picPath\":\"\\\\api/upload/images/product/P1475135453169001/71f1bd825854153ae1cc87011da2ef32.png\",\"status\":\"1\"
import Foundation

struct OrderListModel: HandyJSON {
    var orderList: [OrderModel]?
}

struct OrderModel: HandyJSON {
    var productId: Int?
    var orderId: Int?
    var orderName:String?
    var orderCode:String?
    var createTime: Int64?
    var expressPrice: Int?
    var productPrice: Int?
    var productNum: Int?
    var productTotal: Int?
    var picPath:String?
    var status: Int?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &picPath) { (string) -> (String) in
            //            return "http://120.24.3.172:8080/feigou-api" + string
            return "https://source.unsplash.com/random/480x\(300 + arc4random() % 10)"
        }
    }
}
