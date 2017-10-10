# AdvertScrollView


## 效果图

![](https://github.com/dongxiexidu/AdvertScollViewExample/blob/master/demo.gif)


### Dependency

[Kingfisher](https://github.com/onevcat/Kingfisher)



## 代码介绍（详细使用，请参考 Demo）

#### 例一
```Objective-C
advertScrollViewCenter.titleColor = UIColor.green
advertScrollViewCenter.scrollTimeInterval = 5
advertScrollViewCenter.titles = ["京东、天猫等 app 首页常见的广告滚动视图", "采用代理设计模式进行封装, 可进行事件点击处理", "建议在 github 上下载"]
advertScrollViewCenter.titleFont = UIFont.systemFont(ofSize: 14)
advertScrollViewCenter.delegate = self
```

#### 代理方法
```Objective-C
func advertScrollView(advertScrollView: AdvertScrollView, index: NSInteger) {
print(index)
}
```

#### 例二
```Objective-C
advertScrollViewBottom.advertScrollViewStyle = AdvertScrollViewStyle.more
advertScrollViewBottom.topSignImages = ["dot", "dot", "dot"]
advertScrollViewBottom.topTitles = ["聚惠女王节，香米更低价满150减10", "HTC新品首发，预约送大礼包", "“挑食”进口生鲜，满199减20"]
advertScrollViewBottom.bottomSignImages = ["dot", "dot", "dot"]
advertScrollViewBottom.bottomTitles = ["满150减10+满79减5", "12期免息＋免费试用", "领券满199减20+进口直达"]
```

#### 原作者
[kingsic](https://github.com/kingsic/SGAdvertScrollView)
