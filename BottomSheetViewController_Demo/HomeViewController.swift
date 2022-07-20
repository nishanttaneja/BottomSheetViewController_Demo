//
//  HomeViewController.swift
//  BottomSheetViewController_Demo
//
//  Created by Nishant Taneja on 20/07/22.
//

import UIKit
import BottomSheet

class HomeViewController: UIViewController, HomeViewDelegate {
    
    private let visualEffectView = UIVisualEffectView()
    
    
    // MARK: - HomeViewDelegate
    
    func homeView(_ view: HomeView, didSelect button: UIButton) {
        let bottomSheetVC = CustomBottomSheetViewController()
        bottomSheetVC.delegate = self
        present(bottomSheetVC, animated: true)
    }
    
    
    // MARK:  - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.isUserInteractionEnabled = false
        title = kHomeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        updateView()
        navigationController?.view.addSubview(visualEffectView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        visualEffectView.frame = view.frame
    }
    
    private func updateView() {
        let homeView = HomeView(frame: view.frame)
        homeView.delegate = self
        view = homeView
    }
}


// MARK: - BottomSheetViewControllerDelegate

extension HomeViewController: BottomSheetViewControllerDelegate {
    func bottomSheetViewControllerWillAppear(withDuration animationDuration: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    func bottomSheetViewControllerWillDisappear(withDuration animationDuration: CGFloat) {
        UIView.animate(withDuration: animationDuration) {
            self.visualEffectView.effect = nil
        }
    }
}
