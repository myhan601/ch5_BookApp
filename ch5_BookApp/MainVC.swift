//
//  MainVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/7/24.
//

import UIKit

class MainVC: UIViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    var tableView: UITableView!
    
    var books: [Book] = []
    var searchResults: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
//        fetchBooks()
    }
    
//    func fetchBooks() {
//        BookManager.fetchBooks { [weak self] (books) in
//            DispatchQueue.main.async {
//                if let books = books {
//                    self?.books = books
//                    self?.tableView.reloadData()
//                } else {
//                    print("도서 정보를 불러오는 데 실패했습니다.")
//                }
//            }
//        }
//    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        configureSearchBar()
        configureTableView()
    }
    
    private func setupConstraints() {
        // 서치바 오토레이아웃 설정
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // 테이블뷰 오토레이아웃 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(MainVCTableCell.self, forCellReuseIdentifier: MainVCTableCell.Identifier)
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: SearchResultTableCell.Identifier)
        view.addSubview(tableView)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        // BookManager의 fetchBooks 메서드를 사용하여 온라인에서 책 정보 검색
        BookManager.fetchBooks(query: searchText) { [weak self] books in
            DispatchQueue.main.async {
                // 온라인 검색 결과를 searchResults에 할당하고 테이블 뷰 리로드
                self?.searchResults = books ?? []
                self?.tableView.reloadData()
                
                // 검색 완료 후 키보드 숨김 처리
                searchBar.resignFirstResponder()
            }
        }
    }

}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // 첫 번째 섹션의 셀 구성
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainVCTableCell.Identifier, for: indexPath) as? MainVCTableCell else {
                return UITableViewCell()
            }
            // 셀에 대한 추가적인 설정
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableCell.Identifier, for: indexPath) as! SearchResultTableCell
            // cell의 설정
            cell.delegate = self
            cell.configureWithBooks(searchResults)
            cell.selectionStyle = .none
            return cell
        default:
            // 기본 셀 반환
            return UITableViewCell()
        }
    }
    
    // 섹션의 개수를 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // 각 섹션 별 행의 수를 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1 // 여기서 0보다 큰 값을 반환해야 함
        default:
            return 0
        }
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 500
        default:
            return 80
        }
    }
}

extension MainVC: SearchResultCellDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        // DetailVC 인스턴스 생성
        let detailVC = DetailVC()
        // DetailVC를 모달로 표시
        present(detailVC, animated: true, completion: nil)
        print("modal")
    }
}
