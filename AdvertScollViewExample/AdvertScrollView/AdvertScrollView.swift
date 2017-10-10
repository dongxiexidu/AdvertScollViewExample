//
//  AdvertScrollView.swift
//  FashionMall
//
//  Created by fashion on 2017/10/9.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit
import Kingfisher

let advertScrollViewMaxSections : Double = 100
let advertScrollViewTitleFont : CGFloat = 13

enum AdvertScrollViewStyle {
    /// 一行文字滚动样式
    case normal
    /// 二行文字滚动样式
    case more
}

protocol AdvertScrollViewDelegate:NSObjectProtocol {
    //设置协议方法
    func advertScrollView(advertScrollView : AdvertScrollView,index : NSInteger)
}

class AdvertScrollView : UIView {
    
    // MARK: - 公共 API
    /** delegate */
    weak var delegate:AdvertScrollViewDelegate?
    
    /** 默认 AdvertScrollViewStyleNormal 样式 */
    var advertScrollViewStyle : AdvertScrollViewStyle!{
        didSet{
            if advertScrollViewStyle == .more {
                collectionView.register(AdvertScrollViewMoreCell.self, forCellWithReuseIdentifier: advertScrollViewMoreCell)
            }
        }
    }
    
    /** 滚动时间间隔，默认为3s */
    var scrollTimeInterval : CFTimeInterval = 3.0
    
    /** 标题字体字号，默认为13号字体 */
    var titleFont : UIFont?
    
    // MARK: - SGAdvertScrollViewStyleNormal 样式下的 API
    /** 左边标志图片数组 */
    var signImages : [String]?{
        didSet{
            guard let signImages = signImages else {
                return
            }
            imageArr = signImages
        }
    }
    
    /** 标题数组 */
    var titles : [String]? {
        didSet{
            if (titles?.count)! > 0 {
                addTimer()
            }else{
                removeTimer()
            }
            titleArr = titles!
            collectionView.reloadData()
        }
    }
    
    /** 标题字体颜色，默认为黑色 */
    var titleColor : UIColor?
    
    /** 标题文字位置，默认为 NSTextAlignmentLeft，仅仅针对标题起作用 */
    var textAlignment : NSTextAlignment?
    
    
    // MARK: - AdvertScrollViewStyleMore 样式下的 API
    /** 顶部左边标志图片数组 */
    var topSignImages : [String]?{
        didSet{
            guard let topSignImages = topSignImages else {
                return
            }
            imageArr = topSignImages
        }
    }
    /** 顶部标题数组 */
    var topTitles : [String]? {
        didSet{
            if (topTitles?.count)! > 1 {
                addTimer()
            }else{
                removeTimer()
            }
            titleArr = topTitles!
            self.collectionView.reloadData()
        }
    }
    
    /** 底部左边标志图片数组 */
    var bottomSignImages : [String]?
    
    /** 底部标题数组 */
    var bottomTitles  : [String]?
    
    /** 顶部标题字体颜色，默认为黑色 */
    var topTitleColor : UIColor?
    
    /** 底部标题字体颜色，默认为黑色 */
    var bottomTitleColor : UIColor?
    
    
    var timer : Timer?
    var titleArr = [String]()
    var imageArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialization()
        setupSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        initialization()
        setupSubviews()
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            removeTimer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
        setupSubviews()
       // fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flowLayout.itemSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
        collectionView.frame = self.bounds
        if titleArr.count > 1 {
            defaultSelectedScetion()
        }
    }
    
    fileprivate func defaultSelectedScetion() {
        let indexPath = IndexPath.init(row: 0, section: Int(0.5*advertScrollViewMaxSections))
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
    }
    
    fileprivate func initialization() {
        scrollTimeInterval = 3.0
        addTimer()
        advertScrollViewStyle = AdvertScrollViewStyle.normal
    }
    
    fileprivate func setupSubviews() {
        let tempView = UIView.init(frame: CGRect.zero)
        self.addSubview(tempView)
        self.addSubview(collectionView)
    }
    lazy var flowLayout : UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        return flowLayout
    }()
    
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AdvertScrollViewNormalCell.self, forCellWithReuseIdentifier: advertScrollViewNormalCell)
        
        return collectionView
    }()
    
    fileprivate func addTimer() {
        removeTimer()

        timer = Timer.init(timeInterval: scrollTimeInterval, target: self, selector: #selector(beginUpdateUI), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc fileprivate func beginUpdateUI() {
        if self.titleArr.count == 0 {
            return
        }
        
        // 1、当前正在展示的位置
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last
        
        // 马上显示回最中间那组的数据
        let resetCurrentIndexPath = IndexPath.init(row: currentIndexPath!.item, section: Int(0.5*advertScrollViewMaxSections))
        collectionView.scrollToItem(at: resetCurrentIndexPath, at: .bottom, animated: false)
        
        // 2、计算出下一个需要展示的位置
        var nextItem = resetCurrentIndexPath.item + 1
        var nextSection = resetCurrentIndexPath.section
        
        if nextItem == titleArr.count {
            nextItem = 0
            nextSection = nextSection+1
        }
        
        let nextIndexPath = IndexPath.init(item: nextItem, section: nextSection)
        
        // 3、通过动画滚动到下一个位置
        collectionView.scrollToItem(at: nextIndexPath, at: .bottom, animated: true)
    }
    

    
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    deinit {
        collectionView.delegate = nil;
        collectionView.dataSource = nil;
    }
}

fileprivate let advertScrollViewNormalCell = "advertScrollViewNormalCell"
fileprivate let advertScrollViewMoreCell = "advertScrollViewMoreCell"

// MARK: - UICollectionView 的 dataSource、delegate方法
extension AdvertScrollView : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(advertScrollViewMaxSections)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.advertScrollView(advertScrollView: self, index: indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if advertScrollViewStyle == .more {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertScrollViewMoreCell, for: indexPath) as! AdvertScrollViewMoreCell
            do{
                if imageArr.count > 0 {
                    let topImagePath : String  = imageArr[indexPath.item]
                    if topImagePath.hasPrefix("http") == true {
                        cell.topSignImageView.kf.setImage(with: URL.init(string: topImagePath))
                    }else{
                        cell.topSignImageView.image = UIImage.init(named: topImagePath)
                    }
                }
                cell.topLabel.text = titleArr[indexPath.item]
            }
            
            
            do {
                if (bottomSignImages?.count)! > 0{
                    let imagePath : String  = bottomSignImages![indexPath.item]
                    if imagePath.hasPrefix("http") == true {
                        cell.bottomSignImageView.kf.setImage(with: URL.init(string: imagePath))
                    }else{
                        cell.bottomSignImageView.image = UIImage.init(named: imagePath)
                    }
                }
                cell.bottomLabel.text = bottomTitles?[indexPath.item]
            }
        
            if let titleFont = titleFont{
                cell.topLabel.font = titleFont
                cell.bottomLabel.font = titleFont
            }
            if let topTitleColor  = topTitleColor {
                cell.topLabel.textColor = topTitleColor;
            }
            if let bottomTitleColor = bottomTitleColor {
                cell.bottomLabel.textColor = bottomTitleColor;
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertScrollViewNormalCell, for: indexPath) as! AdvertScrollViewNormalCell
            if imageArr.count > 0{
                let imagePath : String  = imageArr[indexPath.item]
                if imagePath.hasPrefix("http") == true {
                    cell.signImageView.kf.setImage(with: URL.init(string: imagePath))
                }else{
                    cell.signImageView.image = UIImage.init(named: imagePath)
                }
            }
            cell.titleLabel.text = titleArr[indexPath.item]
            
            if let textAlignment = textAlignment {
                cell.titleLabel.textAlignment = textAlignment
            }
            if let titleFont = titleFont {
                cell.titleLabel.font = titleFont;
            }
            if let titleColor = titleColor {
                cell.titleLabel.textColor = titleColor
            }
            return cell
        }
    } 
}
