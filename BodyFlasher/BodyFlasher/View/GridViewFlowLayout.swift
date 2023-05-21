//
//  GridViewFlowController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-20.
//

import UIKit

class GridViewFlowLayout: UICollectionViewFlowLayout {
    
    var width: Int = 0
    var height: Int = 0
    
    init(width: Int, height: Int) {
        super.init()
        self.width = width
        self.height = height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        itemSize = CGSize(width: width, height: height)
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.collectionViewLayout = self
    }
}
