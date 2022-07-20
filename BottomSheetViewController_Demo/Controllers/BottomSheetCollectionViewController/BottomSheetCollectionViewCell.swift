//
//  BottomSheetCollectionViewCell.swift
//  BottomSheetViewController_Demo
//
//  Created by Nishant Taneja on 20/07/22.
//

import UIKit

class BottomSheetCollectionViewCell: UICollectionViewCell {
    class func getReuseIdentifier() -> String {
        "BottomSheetCollectionViewCell-UICollectionViewCell"
    }
    class func getHeight(in targetWidth: CGFloat) -> CGFloat {
        44
    }
    
    func update(using item: BottomSheetCollectionViewCellRepresentable) {
        backgroundColor = .green
    }
}
