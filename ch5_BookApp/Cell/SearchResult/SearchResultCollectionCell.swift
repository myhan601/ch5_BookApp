//
//  SearchResultCell.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/8/24.
//

import UIKit

class SearchResultCollectionCell: UICollectionViewCell {
    
    static let identifier = "SearchResultCollectionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(priceLabel)
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        // authorLabel
        NSLayoutConstraint.activate([
            authorLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8)
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with title: String, author: String, price: String) {
        titleLabel.text = title
        authorLabel.text = author
        priceLabel.text = price
    }
}

