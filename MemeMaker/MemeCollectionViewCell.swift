//
//  MemeCollectionViewCell.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 05.07.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    let memeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        return imageview
    }()
    
    var meme: UIImage? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    override func layoutSubviews() {
        if let image = meme {
            memeImageView.image = image
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        self.addSubview(memeImageView)
        
        NSLayoutConstraint.activate([
            memeImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            memeImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            memeImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            memeImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            ])
    }
}
