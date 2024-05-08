//
//  MainVCTableCell.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/8/24.
//

import UIKit

class MainVCTableCell: UITableViewCell {
    
    static let Identifier = "MainVCTableCell"
    var collectionView: UICollectionView!
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 본 책"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 컬렉션뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100) // 아이템 크기 설정
        
        // 컬렉션뷰 초기화 및 설정
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true // 가로 스크롤이 항상 활성화되도록 설정
        
        collectionView.register(MainVCCollectionVCell.self, forCellWithReuseIdentifier: MainVCCollectionVCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(collectionView)
        addSubview(titleLabel)
        
        // titleLabel 오토레이아웃 설정
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
        
        // collectionView 오토레이아웃 설정
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 100), // 컬렉션뷰 높이 설정
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5) // 이 부분은 셀의 크기에 맞게 조절해야 할 수 있음
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MainVCTableCell: UICollectionViewDataSource {
    // 섹션당 아이템의 개수를 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 예시로 10개의 아이템을 반환
    }

    // 각 아이템에 대한 셀을 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCCollectionVCell.identifier, for: indexPath) as! MainVCCollectionVCell
        // cell 구성 코드 (예: cell.titleLabel.text = "아이템 \(indexPath.row)")
        return cell
    }
    
}

extension MainVCTableCell: UICollectionViewDelegate {
    
}
