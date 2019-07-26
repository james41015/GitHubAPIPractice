//
//  ResultCollectionViewCell.swift
//  GitHubAPIPractice
//
//  Created by Hong James on 2019/7/26.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit

class ResultCollectionViewCell: UICollectionViewCell {
    var resultImageView = UIImageView()
    var titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel.textAlignment = .center
        
        self.contentView.addSubview(resultImageView)
        self.contentView.addSubview(titleLabel)
        
        self.resultImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-40)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
