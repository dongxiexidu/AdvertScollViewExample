//
//  AdvertScrollViewMoreCell.swift
//  FashionMall
//
//  Created by fashion on 2017/10/10.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit

class AdvertScrollViewMoreCell: UICollectionViewCell {
    var topSignImageView = UIImageView()
    var bottomSignImageView = UIImageView()
    
    lazy var topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.textColor = UIColor.black
        topLabel.font = UIFont.systemFont(ofSize: advertScrollViewTitleFont)
        return topLabel
    }()
    lazy var bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.textColor = UIColor.black
        bottomLabel.font = UIFont.systemFont(ofSize: advertScrollViewTitleFont)
        return bottomLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        contentView.addSubview(topSignImageView)
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomSignImageView)
        contentView.addSubview(bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing : CGFloat = 5
        let topSignImageViewW = topSignImageView.image?.size.width == nil ? 0 : topSignImageView.image?.size.width
        let topSignImageViewH = topSignImageView.image?.size.height == nil ? 0 : topSignImageView.image?.size.height
        let topSignImageViewX : CGFloat = 0
        let topSignImageViewY : CGFloat = spacing
        topSignImageView.frame = CGRect.init(x: topSignImageViewX, y: topSignImageViewY, width: topSignImageViewW!, height: topSignImageViewH!)
        
        
        var topLabelX : CGFloat = 0
        if topSignImageView.image == nil {
            topLabelX = 0
        }else{
            topLabelX = topSignImageView.frame.maxX + 0.5 * spacing
        }
        
        let topLabelY : CGFloat = topSignImageViewY
        let topLabelW : CGFloat = self.frame.size.width - topLabelX
        let topLabelH : CGFloat = (self.frame.size.height - 2 * topLabelY) * 0.5
        topLabel.frame = CGRect.init(x: topLabelX, y: topLabelY, width: topLabelW, height: topLabelH)
        
        var topPoint : CGPoint = topSignImageView.center
        topPoint.y = topLabel.center.y
        topSignImageView.center = topPoint
        
        let bottomSignImageViewW = bottomSignImageView.image?.size.width == nil ? 0 : bottomSignImageView.image?.size.width
        let bottomSignImageViewH = bottomSignImageView.image?.size.height == nil ? 0 : bottomSignImageView.image?.size.height
        let bottomSignImageViewX : CGFloat = 0
        let bottomSignImageViewY : CGFloat = topLabel.frame.maxY
        bottomSignImageView.frame = CGRect.init(x: bottomSignImageViewX, y: bottomSignImageViewY, width: bottomSignImageViewW!, height: bottomSignImageViewH!)
        var bottomLabelX : CGFloat = 0
        if bottomSignImageView.image == nil {
            bottomLabelX = 0
        }else{
            bottomLabelX = bottomSignImageView.frame.maxX + 0.5 * spacing
        }
        
        let bottomLabelY : CGFloat = topLabel.frame.maxY
        let bottomLabelW : CGFloat = self.frame.size.width - bottomLabelX
        let bottomLabelH : CGFloat = topLabelH
        bottomLabel.frame = CGRect.init(x: bottomLabelX, y: bottomLabelY, width: bottomLabelW, height: bottomLabelH)
        var bottomPoint : CGPoint = bottomSignImageView.center
        bottomPoint.y = bottomLabel.center.y
        bottomSignImageView.center = bottomPoint
        
    }
}
