//
//  SavedBookTableViewCell.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//

import UIKit

class SavedBookTableViewCell: UITableViewCell {
    
    // 셀의 identifier를 static let을 사용하여 정의합니다.
    static let identifier = "SavedBookTableViewCell"
    
    // 책 제목과 가격을 나타내기 위한 UILabel을 선언합니다.
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        // 오토레이아웃을 사용하기 위해 false로 설정합니다.
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        // 오토레이아웃을 사용하기 위해 false로 설정합니다.
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 뷰에 titleLabel과 priceLabel을 추가합니다.
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // titleLabel과 priceLabel에 대한 제약조건을 설정합니다.
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // 오른쪽 끝으로 이동
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    
    // 셀에 책 제목과 가격을 설정하는 메서드를 추가합니다.
    public func configure(with title: String, price: String) {
        titleLabel.text = title
        priceLabel.text = price
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


