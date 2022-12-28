//
//  ChartViewController.swift
//  GyroData
//
//  Created by 이원빈 on 2022/12/28.
//

import UIKit

final class MeasureViewController: UIViewController {
    let measureView = MeasureView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = measureView
        setupNavigation()
    }
    
    private func setupNavigation() {
        let rightButton: UIBarButtonItem = {
             let button = UIBarButtonItem(
                title: "저장",
                style: .plain,
                target: self,
                action: #selector(saveButtonDidTapped)
             )
             
             return button
         }()
        self.navigationItem.title = "측정하기"
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func saveButtonDidTapped() {
        print("저장")
    }
}
