//
//  BottomSheetCollectionViewCellRepresentable.swift
//  BottomSheetViewController_Demo
//
//  Created by Nishant Taneja on 20/07/22.
//

import Foundation

protocol BottomSheetCollectionViewCellRepresentable {
    var cellType: BottomSheetCollectionViewCell.Type { get }
}

struct Item: BottomSheetCollectionViewCellRepresentable {
    let cellType: BottomSheetCollectionViewCell.Type = BottomSheetCollectionViewCell.self
}
