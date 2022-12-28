//
//  MeasureViewModel.swift
//  GyroData
//
//  Created by brad on 2022/12/28.
//

import Foundation

final class MeasureViewModel {
    private let coreDataManager = CoreDataManager()
    private let fileHandlerManager = FileHandleManager()
    private let coreMotionManager = CoreMotionManager()
        
    init() {
        coreDataManager.fileManager = fileHandlerManager
    }
    
    func startCoreMotion(of SensorType: Sensor) {
        coreMotionManager.startMeasure(of: SensorType)
    }
    
    func stopCoreMotion() {
        coreMotionManager.stopMeasure()
    }
    
    func saveCoreMotion() {
        coreDataManager.create(data: coreMotionManager.deliverMeasureData())
    }
}
