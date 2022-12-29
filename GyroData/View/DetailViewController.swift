//
//  DetailViewController.swift
//  GyroData
//
//  Created by 이원빈 on 2022/12/29.
//

import UIKit

enum DetailType: String {
    case view = "View"
    case play = "Play"
}

final class DetailViewController: UIViewController {
    private var currenType: DetailType?
    private let detailView = DetailView()
    
    init(data: MeasuredData,type: DetailType) {
        super.init(nibName: nil, bundle: nil)
        detailView.setupMode(data: data, type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        setupNavigationBar()
        setupButton()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "다시보기"
    }
    
    func setupButton() {
        detailView.playButton.addTarget(
            self,
            action: #selector(playButtonDidTapped),
            for: .touchUpInside
        )
    }
    
    @objc func playButtonDidTapped() {
        if detailView.playButton.image(for: .normal) == UIImage(systemName: "play.fill") {
            detailView.playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            // play 중인 상황
        } else {
            detailView.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            // stop 상황
        }
    }
}
