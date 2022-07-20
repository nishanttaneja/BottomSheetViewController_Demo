//
//  ViewController.swift
//  BottomSheetViewController_Demo
//
//  Created by Nishant Taneja on 20/07/22.
//

import UIKit
import BottomSheet

class CustomBottomSheetViewController: BottomSheetViewController {
    // MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = kBottomSheetTitle
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = kPlaceholderText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    
    // MARK: - BottomSheetView
    
    // MARK: DataSource
    
    override func viewToDisplayAsBottomSheetView() -> UIView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textLabel, .init()])
        stackView.axis = .vertical
        return stackView
    }
    
    override func config() {
        super.config()
        bottomSheetView.minimumHeight = 400
    }
}
