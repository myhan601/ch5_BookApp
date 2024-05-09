//
//  SearchResultTableCell.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/8/24.
//

import UIKit


protocol SearchResultCellDelegate: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}


class SearchResultTableCell: UITableViewCell {
    
    weak var delegate: SearchResultCellDelegate?
    
    static let Identifier = "SearchResultTableCell"
    var collectionView: UICollectionView!
    
    var books = [Book]()
    
    func configureWithBooks(_ books: [Book]) {
        self.books = books
        // UICollectionView를 새로고침하여 데이터를 표시합니다.
        self.collectionView.reloadData()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 이 부분을 추가합니다.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            // titleLabel 아래에 collectionView를 배치합니다.
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 300, height: 70) // 적절한 사이즈로 조정하세요
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: SearchResultCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension SearchResultTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count // 실제 books 배열의 개수를 반환하도록 수정
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionCell.identifier, for: indexPath) as? SearchResultCollectionCell else {
            fatalError("Unable to dequeue SearchResultCollectionCell")
        }
        
        // books 배열에서 해당 indexPath에 해당하는 Book 객체를 가져옵니다.
        let book = books[indexPath.row]
        
        // configure 메소드를 호출하여 셀의 내용을 설정합니다.
        cell.configure(with: book)
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 8.0
        return cell
        
    }
}


extension SearchResultTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
        // 여기서 indexPath.row를 사용하여 클릭된 셀의 데이터를 참조할 수 있습니다.
        print("셀 \(indexPath.row)이(가) 클릭되었습니다.")
    }
}
