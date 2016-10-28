//
//  FeiGouApi.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/10/27.
//  Copyright © 2016年 like. All rights reserved.
//

import UIKit
import Alamofire

private typealias JSONObject = [String : AnyObject]


class FeiGouApi: NSObject {

    static let shareInstance = FeiGouApi()
    
    let baseApi = "http://120.24.3.172:8080/feigou-api/"
    
    func getHomeList(pageNum:Int, pageSize:Int, completion: @escaping (ProductModel) -> Void) {
        request(urlString: "index/ad/productList", parameters: ["pageNum":"\(pageNum)", "pageSize":"\(pageSize)"]) { (jsonStr) in
            if let model = JSONDeserializer<ProductModel>.deserializeFrom(json: jsonStr) {
                completion(model)
            }
        }
    }
    
    func getHomeBanner(completion: @escaping () -> Void) {
//        request(urlString: "api/upload/", parameters: <#T##[String : String]?#>, completion: <#T##(String?) -> Void#>)
    }
    
    func getHomeCategory(completion: @escaping (categoryModel) -> Void) {
        request(urlString: "index/category", parameters: nil) { (jsonStr) in
            if let model = JSONDeserializer<categoryModel>.deserializeFrom(json: jsonStr) {
                completion(model)
            }
        }
    }

    func request(urlString: String, parameters: [String: String]?, completion: @escaping (String?) -> Void) {
        
        let url = URL.init(string: baseApi + urlString)!
        Alamofire.request(url, parameters: parameters).responseJSON { (json) in
            let jsonStr = String.init(data: json.data!, encoding: .utf8)!
            completion(jsonStr)
        }
        
    }
}
