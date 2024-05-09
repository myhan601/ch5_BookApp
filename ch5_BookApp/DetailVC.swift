//
//  DetailVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//

import UIKit

class DetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 책 제목 레이블
        let titleLabel = UILabel()
        titleLabel.text = "책 제목"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // 저자 레이블
        let authorLabel = UILabel()
        authorLabel.text = "저자"
        authorLabel.textAlignment = .center
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorLabel)
        
        // 이미지 뷰 (테스트용으로 배경색 회색)
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // 가격 레이블
        let priceLabel = UILabel()
        priceLabel.text = "가격"
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        // 상세 설명 레이블
        let descriptionLabel = UILabel()
        descriptionLabel.text = "상세 설명"
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0 // 여러 줄 표시 가능
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            // 책 제목 레이블
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 저자 레이블
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 이미지 뷰
            imageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200), // 예시로 높이 200 설정
            
            // 가격 레이블
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 상세 설명 레이블
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // x 버튼
        let closeButton = UIButton()
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .lightGray
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.layer.cornerRadius = 8
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        view.addSubview(closeButton)
        
        // 담기 버튼
        let addToCartButton = UIButton()
        addToCartButton.setTitle("담기", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.backgroundColor = .systemGreen
        addToCartButton.layer.cornerRadius = 8
        addToCartButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        view.addSubview(addToCartButton)
        
        // 버튼 제약 조건 설정
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            
            addToCartButton.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 3)
        ])
    }
    @objc func dismissModal() {
            self.dismiss(animated: true, completion: nil)
    }
}

