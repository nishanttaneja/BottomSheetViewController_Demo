//
//  BottomSheetCollectionViewController.swift
//  BottomSheetViewController_Demo
//
//  Created by Nishant Taneja on 20/07/22.
//

import UIKit
import BottomSheet

protocol BottomSheetCollectionViewControllerDataSource: NSObjectProtocol {
    func representableItems(inBottomSheetCollectionViewController controller: BottomSheetCollectionViewController) -> [BottomSheetCollectionViewCellRepresentable]
}

protocol BottomSheetCollectionViewControllerDelegate: BottomSheetViewControllerDelegate {}

class BottomSheetCollectionViewController: BottomSheetViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView
    
    private let cellReuseIdentifier = "BottomSheetCollectionViewController_cell"
    private let defaultCellHeight: CGFloat = 44
    private let lineSpacing: CGFloat = 4
    
    private var collectionView: UICollectionView! = nil
    
    weak var collectionDataSource: BottomSheetCollectionViewControllerDataSource? = nil {
        willSet {
            items = newValue?.representableItems(inBottomSheetCollectionViewController: self) ?? []
            items.forEach({
                collectionView.register($0.cellType.self, forCellWithReuseIdentifier: $0.cellType.getReuseIdentifier())
            })
        }
    }
    weak var collectionDelegate: BottomSheetCollectionViewControllerDelegate? = nil
    
    private var items: [BottomSheetCollectionViewCellRepresentable] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                // update minimum height
                if let maxContentHeight: CGFloat = self?.getEstimatedMaximumCollectionViewHeight(),
                   let sheetBarHeight: CGFloat = self?.bottomSheetView.contentBarHeight,
                   let sheetBottomPadding: CGFloat = self?.bottomSheetView.padding {
                    let minSheetHeight: CGFloat = maxContentHeight + sheetBarHeight + sheetBottomPadding + 34 // bottom safe area
                    self?.bottomSheetView.setContentMinimumHeight(minSheetHeight)
                }
            }
        }
    }
    
    func getCollectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = lineSpacing
        return flowLayout
    }
    
    func configCollectionView() {
        let layout = getCollectionViewLayout()
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    func getEstimatedMaximumCollectionViewHeight() -> CGFloat {
        let targetWidth: CGFloat = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        return items.reduce(.zero) { partialResult, item in
            partialResult + item.cellType.getHeight(in: targetWidth) + lineSpacing
        }
    }
    
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        guard indexPath.item < items.count else { return defaultCell }
        let item = items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellType.getReuseIdentifier(), for: indexPath) as? BottomSheetCollectionViewCell else { return defaultCell }
        cell.update(using: item)
        return cell
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let targetWidth: CGFloat = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height: CGFloat = indexPath.item < items.count ? items[indexPath.item].cellType.getHeight(in: targetWidth) : defaultCellHeight
        return CGSize(width: targetWidth, height: height)
        
    }
    
    
    // MARK: - BottomSheetView-DataSource
    
    override func viewToDisplayAsBottomSheetView() -> UIView {
        collectionView
    }
    
    
    // MARK: - Configuration
    
    override func config() {
        configCollectionView()
        super.config()
    }
}
