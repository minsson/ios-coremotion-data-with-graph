//
//  ChartViewController.swift
//  GyroData
//
//  Created by 이원빈 on 2022/12/28.
//

import UIKit

final class MeasureViewController: UIViewController {
    private let measureViewModel = MeasureViewModel()
    private let measureView = MeasureView()
    
    private var sensor: Sensor = Sensor.gyro
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = measureView
        setupNavigation()
        setupButtons()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sensor = Sensor.gyro
        case 1:
            sensor = Sensor.accelerometer
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
    
    func setupNavigation() {
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
