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
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 170, width: 390, height: 200))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.isScrollEnabled = false

        tableView.register(MainVCTableCell.self, forCellReuseIdentifier: MainVCTableCell.Identifier)

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀을 재사용 큐에서 가져오거나 새로 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: MainVCTableCell.Identifier, for: indexPath) as! MainVCTableCell
        cell.selectionStyle = .none
        // 셀에 대한 설정
//        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell // 셀 반환
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
