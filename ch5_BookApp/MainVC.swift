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
        self.view.backgroundColor = .systemBackground
        
        // 서치바 기본 설정
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        self.view.addSubview(searchBar)
        // 오토레이아웃 설정 (예제에서는 프레임을 직접 설정)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 170, width: 390, height: 700))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.isScrollEnabled = false
        
        tableView.register(MainVCTableCell.self, forCellReuseIdentifier: MainVCTableCell.Identifier)
        tableView.register(SearchResultTableCell.self, forCellReuseIdentifier: SearchResultTableCell.Identifier)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 사용자가 검색 버튼을 눌렀을 때 호출됩니다.
        // 검색어 처리 로직을 구현합니다.
        guard let searchText = searchBar.text else { return }
        print("검색어: \(searchText)")
        
        // 키보드 숨기기
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
