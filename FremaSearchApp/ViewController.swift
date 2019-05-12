//
//  ViewController.swift
//  FremaSearchApp
//
//  Created by YutaSanada on 2019/05/12.
//  Copyright © 2019 YutaSanada. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        scrapeWebsite()
    }

    func scrapeWebsite() {
        
        //GETリクエスト 指定URLのコードを取得
        Alamofire.request("https://www.mercari.com/jp/search/?keyword=Swift+%E6%9C%AC").responseString { response in
            print("\(response.result.isSuccess)")
            
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) {
        if let doc = try? HTML(html: html, encoding: .utf8) {
            print(doc.css("section"))
            for link in doc.css("section[class^='items-box']") {
                let itemTitle = link.at_css("h3")?.content
                var aTag = link.css("a[href]").first
                let href = aTag?["href"]
                let imgTag = link.css("img").first
                let image = imgTag?["data-src"]
                let price = link.css("div[class^='items-box-price']").first?.text
                print("title: \(String(describing: itemTitle ?? nil))")
                print("link: \(String(describing: href ?? nil))")
                print("img: \(String(describing: image ?? nil))")
                print("price: \(String(describing: price ?? nil))")
            }
        }
    }
}

