//
//  MeasureViewController.swift
//  GyroData
//
//  Created by 이원빈 on 2022/12/29.
//

import UIKit

final class MeasureViewController: UIViewController {
    private let measureViewModel = MeasureViewModel()
    private let measureView = MeasureView()
    
    private var sensor: Sensor = Sensor.accelerometer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = measureView
        setupNavigationBar()
        setupButtons()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sensor = Sensor.accelerometer
        case 1:
            sensor = Sensor.gyro
        default:
            return
        }
    }
    
    @objc func saveButtonDidTapped() {
        measureViewModel.saveCoreMotion()
    }
    
    @objc func startButtonDidTapped() {
        measureViewModel.startCoreMotion(of: sensor)
    }
    
    @objc func stopButtonDidTapped() {
        measureViewModel.stopCoreMotion()
    }
}

private extension MeasureViewController {
    
    func setupNavigationBar() {
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
    
    func setupButtons() {
        measureView.segmentControl.addTarget(
            self,
            action: #selector(segmentedControlValueChanged),
            for: .valueChanged
        )
        measureView.startButton.addTarget(
            self,
            action: #selector(startButtonDidTapped),
            for: .touchUpInside
        )
        measureView.stopButton.addTarget(
            self,
            action: #selector(stopButtonDidTapped),
            for: .touchUpInside
        )
    }
}
