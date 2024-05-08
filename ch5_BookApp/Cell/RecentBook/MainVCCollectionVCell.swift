//
//  MainVCCollectionVCell.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/8/24.
//

import UIKit

class MainVCCollectionVCell: UICollectionViewCell {
    
    static let identifier = "MainVCCollectionVCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        
        // 이미지뷰 오토레이아웃 설정
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 원 모양으로 만들기
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
}

