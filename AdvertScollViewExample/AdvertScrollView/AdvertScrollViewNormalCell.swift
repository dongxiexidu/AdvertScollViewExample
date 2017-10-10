//
//  AdvertScrollViewNormalCell.swift
//  FashionMall
//
//  Created by fashion on 2017/10/10.
//  Copyright © 2017年 shangZhu. All rights reserved.
//

import UIKit


class AdvertScrollViewNormalCell: UICollectionViewCell {

    var signImageView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: advertScrollViewTitleFont)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        contentView.addSubview(signImageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing : CGFloat = 5
        let signImageViewW = self.signImageView.image?.size.width == nil ? 0 : self.signImageView.image?.size.width
        let signImageViewH = self.signImageView.image?.size.height == nil ? 0 : self.signImageView.image?.size.height
        let signImageViewX : CGFloat = 0
        let signImageViewY : CGFloat = 0
        
        signImageView.frame = CGRect.init(x: signImageViewX, y: signImageViewY, width: signImageViewW!, height: signImageViewH!)
        var labelX : CGFloat = 0
        if signImageView.image == nil {
            labelX = 0
        }else{
            labelX = signImageView.frame.maxX + 0.5 * spacing
        }
        
        let labelY : CGFloat = 0
        let labelW : CGFloat = self.frame.size.width - labelX
        let labelH : CGFloat = self.frame.size.height
        titleLabel.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
        
        var topPoint : CGPoint = signImageView.center
        topPoint.y = titleLabel.center.y
        signImageView.center = topPoint
    }
    
}
