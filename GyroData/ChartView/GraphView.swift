//
//  GraphView.swift
//  GyroData
//
//  Created by minsson on 2022/12/27.
//

import UIKit

protocol GraphDrawable {
    var data: MeasuredData? { get }
    
    func retrieveData(data: MeasuredData?)
    func startDraw()
    func stopDraw()
    
}

protocol TickReceivable {
    func receive(x: Double, y: Double, z: Double)
}

final class GraphView: UIView, TickReceivable {
    private enum Configuration {
        static var lineColors: [UIColor] = [.red, .green, .blue]
        static let lineWidth: CGFloat = 1
    }
    
    var data: MeasuredData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GraphView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        
        let tempData = MeasuredData(uuid: UUID(), date: Date.now, measuredTime: 0.8, sensor: GyroData.Sensor.gyro, sensorData: GyroData.SensorData(axisX: [50, -150, 80, 0.04, 0.07, 0.07, 0.09, 0.09, 0.06, 0.01, -0.06, -0.08, -0.06, 0.01, 0.1, 300, 0.17, 0.17, 0.16, 0.17, 0.2, 0.26, 0.32, 0.36, 0.38, 0.38, 0.36, 0.37, 0.36, 0.33, 0.31, 0.3, 0.31, 0.32, 0.32, 0.32, 0.33, 0.34, 0.37, 0.21, -0.07, 0.02, 0.18, 0.12], axisY: [-0.26, -150, -0.4, -147, -0.57, -0.63, -0.68, -0.8, -0.75, -0.66, -0.53, -0.44, -0.4, -0.43, -0.53, -0.61, -0.6, -0.51, -0.4, -0.35, -0.37, -0.43, -0.53, -0.61, -0.69, -0.72, -0.73, -0.73, -0.64, -0.57, 100, -0.53, 200, -0.51, -0.45, -0.39, -0.38, -0.43, -0.46, -0.27, -0.02, 0.1, -0.02, 0.03], axisZ: [-0.03, -0.06, 70, -80, -0.09, -0.09, -0.05, 0.09, 0.09, 0.12, 0.13, 0.08, -0.01, -0.09, -0.11, -0.11, -0.1, -0.05, 0.01, 0.05, 0.05, 0.03, -0.0, -0.04, -0.06, -0.11, -0.13, -0.11, -0.08, -0.08, -0.07, -0.06, -0.04, -0.02, 0.01, 0.02, 0.03, 0.03, 0.03, 0.06, 0.06, 0.07, 250, 0.06]))
        
        guard let measuredData = self.data else {
            return
        }
        print(tempData)
        drawGraph(of: tempData)
//        print(measuredData)
//        drawGraph(of: measuredData)
    }
    
    func receive(x: Double, y: Double, z: Double) {
        
    }
    
    func retrieveData(data: MeasuredData?) {
        self.data = data
        setNeedsDisplay()
    }
}

private extension GraphView {
    func drawGraph(of measuredData: MeasuredData) {
        let zeroX: CGFloat = 0
        let zeroY: CGFloat = self.frame.height / CGFloat(2)
        let xInterval = self.frame.width / CGFloat(measuredData.measuredTime * 10)
        
        let sensorData: [[Double]] = [
            measuredData.sensorData.axisX,
            measuredData.sensorData.axisY,
            measuredData.sensorData.axisZ
        ]
        
        sensorData.forEach { eachAxisData in
            let path = UIBezierPath()
            let lineColor: UIColor = Configuration.lineColors.removeFirst()
            
            path.move(to: CGPoint(x: zeroX, y: zeroY))
            path.lineWidth = Configuration.lineWidth
            lineColor.setStroke()
            
            path.drawGraph(strideBy: xInterval, with: eachAxisData, axisY: zeroY)
            
            path.stroke()
        }
    }
}

final class GraphContainerView: UIView {
    private enum Configuration {
        static let borderWidth: CGFloat = 4
        static let edgeDistance: CGFloat = 10
    }
    
    private let graphBackgroundView: GraphBackgroundView = {
        let graphBackgroundView = GraphBackgroundView()
        graphBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return graphBackgroundView
    }()
    
    let graphView: GraphView = {
        let graphView = GraphView()
        graphView.translatesAutoresizingMaskIntoConstraints = false
        
        return graphView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupRootView()
        
        addViews()
        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GraphContainerView {
    func setupRootView() {
        self.backgroundColor = .clear
        self.layer.borderWidth = Configuration.borderWidth
    }
    
    func addViews() {
        addSubview(graphView)
        addSubview(graphBackgroundView)
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            graphBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: Configuration.edgeDistance),
            graphBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Configuration.edgeDistance),
            graphBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Configuration.edgeDistance),
            graphBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Configuration.edgeDistance),
            
            graphView.topAnchor.constraint(equalTo: graphBackgroundView.topAnchor),
            graphView.bottomAnchor.constraint(equalTo: graphBackgroundView.bottomAnchor),
            graphView.leadingAnchor.constraint(equalTo: graphBackgroundView.leadingAnchor),
            graphView.trailingAnchor.constraint(equalTo: graphBackgroundView.trailingAnchor)
        ])
    }
}

final class GraphBackgroundView: UIView {
    private enum Configuration {
        static let lineColor = UIColor.black
        static let lineWidth: CGFloat = 1.0
        
        static let numberOfLines = 7
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawBackgroundView()
    }
}

private extension GraphBackgroundView {
    func drawBackgroundView() {
        let path = UIBezierPath()
        path.lineWidth = Configuration.lineWidth
        Configuration.lineColor.setStroke()

        let horizontalLineInterval = bounds.height / CGFloat(Configuration.numberOfLines)
        let verticalLineInterval = bounds.width / CGFloat(Configuration.numberOfLines)

        drawHorizontalLines(Configuration.numberOfLines, interval: horizontalLineInterval, with: path)
        drawVerticalLines(Configuration.numberOfLines, interval: verticalLineInterval, with: path)
        
        path.stroke()
    }
    
    func drawHorizontalLines(_ numberOfLines: Int, interval: CGFloat, with path: UIBezierPath) {
        var y: CGFloat = 0.0
        for _ in 0...numberOfLines {
            path.move(to: CGPoint(x: 0.0, y: y))
            path.addLine(to: CGPoint(x: bounds.width, y: y))
            y += interval
        }
    }
    
    func drawVerticalLines(_ numberOfLines: Int, interval: CGFloat, with path: UIBezierPath) {
        var x: CGFloat = 0.0
        for _ in 0...numberOfLines {
            path.move(to: CGPoint(x: x, y: 0.0))
            path.addLine(to: CGPoint(x: x, y: bounds.height))
            x += interval
        }
    }
}
