//
//  ViewController.swift
//  AdvertScollViewExample
//
//  Created by fashion on 2017/10/10.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,AdvertScrollViewDelegate {
    
    @IBOutlet weak var advertScrollViewTop: AdvertScrollView!
    @IBOutlet var advertScrollView: AdvertScrollView!
    @IBOutlet var advertScrollViewCenter: AdvertScrollView!
    @IBOutlet var advertScrollView2: AdvertScrollView!
    @IBOutlet var advertScrollViewBottom: AdvertScrollView!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // top
        advertScrollViewTop.titles = ["京东、天猫等 app 首页常见的广告滚动视图", "采用代理设计模式进行封装, 可进行事件点击处理", "建议在 github 上下载"]
        advertScrollViewTop.titleColor = UIColor.red
        advertScrollViewTop.textAlignment = .center
        
        
        // 例二
        advertScrollView.signImages = ["hot", "", "activity"]
        advertScrollView.titles = ["京东、天猫等 app 首页常见的广告滚动视图", "采用代理设计模式进行封装, 可进行事件点击处理", "建议在 github 上下载"]
        
        
        // center
        advertScrollViewCenter.titleColor = UIColor.green
        advertScrollViewCenter.scrollTimeInterval = 5
        advertScrollViewCenter.titles = ["京东、天猫等 app 首页常见的广告滚动视图", "采用代理设计模式进行封装, 可进行事件点击处理", "建议在 github 上下载"]
        advertScrollViewCenter.titleFont = UIFont.systemFont(ofSize: 14)
        advertScrollViewCenter.delegate = self
        
        
        // 例四
        let topTitleArr = ["聚惠女王节，香米更低价满150减10", "HTC新品首发，预约送大礼包", "挑食进口生鲜，满199减20"]
        let signImageArr = ["hot", "", "activity"]
        let bottomTitleArr = ["满150减10+满79减5", "12期免息＋免费试用", "领券满199减20+进口直达"]
        advertScrollView2.advertScrollViewStyle = AdvertScrollViewStyle.more
        advertScrollView2.topTitles = topTitleArr
        advertScrollView2.bottomSignImages = signImageArr
        advertScrollView2.bottomTitles = bottomTitleArr
        advertScrollView2.bottomTitleColor = UIColor.red
        
        
        // bottom
        advertScrollViewBottom.advertScrollViewStyle = AdvertScrollViewStyle.more
        advertScrollViewBottom.topSignImages = ["dot", "dot", "dot"]
        advertScrollViewBottom.topTitles = ["聚惠女王节，香米更低价满150减10", "HTC新品首发，预约送大礼包", "“挑食”进口生鲜，满199减20"]
        advertScrollViewBottom.bottomSignImages = ["dot", "dot", "dot"]
        advertScrollViewBottom.bottomTitles = ["满150减10+满79减5", "12期免息＋免费试用", "领券满199减20+进口直达"]
    }
    
    func advertScrollView(advertScrollView: AdvertScrollView, index: NSInteger) {
        print(index)
    }
}

