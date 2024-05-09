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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // 책 정보를 불러와 로그에 출력
        BookManager.fetchBooks { books in
            guard let books = books else {
                print("책 정보를 불러오는 데 실패했습니다.")
                return
            }
            
            // 성공적으로 책 정보를 불러온 경우, 각 책의 제목을 로그에 출력
            for book in books {
                print("제목: \(book.title), 저자: \(book.authors.joined(separator: ", ")), 가격: \(book.price), 할인 가격: \(book.salePrice)")
            }
        }
    }

    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureSearchBar()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 170, width: 390, height: 700))
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.isScrollEnabled = false
        tableView.register(MainVCTableCell.self, forCellReuseIdentifier: MainVCTableCell.Identifier)
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: SearchResultTableCell.Identifier)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        print("검색어: \(searchText)")
        searchBar.resignFirstResponder()
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
