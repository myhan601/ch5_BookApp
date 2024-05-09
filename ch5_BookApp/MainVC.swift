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
        fetchBooks()
    }
    
    func fetchBooks() {
        BookManager.fetchBooks { [weak self] (books) in
            DispatchQueue.main.async {
                if let books = books {
                    // 최대 10개의 요소만 선택하여 books 배열에 할당
                    self?.books = books
                    self?.tableView.reloadData()
                } else {
                    // books가 nil인 경우, 즉 에러가 발생한 경우의 처리
                    print("도서 정보를 불러오는 데 실패했습니다.")
                }
            }
        }
    }
    
    private func setupViews() {
        // 뷰 배경색 설정
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
        
        // 소문자로 변환하여 검색어와 일치하는 책들만 필터링
        searchResults = books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
        searchBar.resignFirstResponder()
        print("검색어: \(searchText)")
        print(searchResults)
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
