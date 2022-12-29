//
//  DetailView.swift
//  GyroData
//
//  Created by 이원빈 on 2022/12/29.
//

import UIKit

final class DetailView: UIView {
    
    let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let graphContainerView: GraphContainerView = {
        let view = GraphContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    // play.fill, stop.fill
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
//        button.setImage(UIImage(systemName: "stop.fill"), for: .selected) //
        button.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "00.0"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        setLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMode(data: MeasuredData, type: DetailType) {
        graphContainerView.graphView.retrieveData(data: data)
        
        dateLabel.text = data.date.translateToString()
        typeLabel.text = type.rawValue
        if type == .view {
            playButton.isHidden = true
            timerLabel.isHidden = true
        }
    }
    
    func addSubviews() {
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(dateLabel)
        labelStackView.addArrangedSubview(typeLabel)
        labelStackView.addArrangedSubview(graphContainerView)
        addSubview(playButton)
        addSubview(timerLabel)
    }
    
    func setLayer() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -300),
            labelStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            typeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            
            graphContainerView.heightAnchor.constraint(equalTo: graphContainerView.widthAnchor),
            graphContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.topAnchor.constraint(equalTo: graphContainerView.bottomAnchor, constant: 40),
            
            timerLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: graphContainerView.trailingAnchor)
        ])
        
    }
}
