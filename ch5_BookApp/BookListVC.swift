//
//  BookListVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/7/24.
//

import UIKit

class BookListVC: UIViewController {
    var books: [Book] = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "전체 삭제", style: .plain, target: self, action: #selector(deleteAllTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // SavedBookTableViewCell의 식별자 등록
        tableView.register(SavedBookTableViewCell.self, forCellReuseIdentifier: SavedBookTableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    @objc func deleteAllTapped() {
        print("전체 삭제 버튼이 클릭되었습니다.")
    }
    
    @objc func addTapped() {
        print("추가 버튼이 클릭되었습니다.")
    }
}

extension BookListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 예시 데이터의 개수를 반환
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedBookTableViewCell.identifier, for: indexPath) as? SavedBookTableViewCell else {
            fatalError("셀을 생성할 수 없습니다.")
        }
        
        let book = books[indexPath.row]
        cell.configure(with: book.title, price: "\(book.price)원")
        return cell
    }
}

extension BookListVC: UITableViewDelegate {
    
}

extension BookListVC: DetailVCDelegate {
    func didAddToCart(book: Book) {
        // 새 책을 books 배열에 추가
        self.books.append(book)
        // 테이블 뷰를 다시 로드하여 변경 사항을 반영
        self.tableView.reloadData()
    }
}
