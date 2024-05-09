//
//  BookListVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/7/24.
//

import UIKit

class BookListVC: UIViewController {
    
    // 테이블 뷰 인스턴스 생성
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 전체 삭제 버튼 설정
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "전체 삭제", style: .plain, target: self, action: #selector(deleteAllTapped))
        
        // 추가 버튼 설정
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        // 테이블 뷰 설정 시작
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        // 오토레이아웃 사용 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // 테스트를 위한 배경색 회색으로 설정
        tableView.backgroundColor = .gray
        
        // 테이블 뷰를 뷰의 서브뷰로 추가
        view.addSubview(tableView)
        
        // 테이블 뷰 오토레이아웃 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    @objc func deleteAllTapped() {
        // 전체 삭제 버튼이 클릭되었을 때 실행할 코드
        print("전체 삭제 버튼이 클릭되었습니다.")
    }
    
    @objc func addTapped() {
        // 추가 버튼이 클릭되었을 때 실행할 코드
        print("추가 버튼이 클릭되었습니다.")
    }
    
    // UITableViewDelegate 프로토콜 메소드 필요시 구현
}

extension BookListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 테스트를 위해 임의의 숫자 반환
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀 생성 또는 재사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        // 테스트를 위해 임시 텍스트 설정
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}

extension BookListVC: UITableViewDelegate {
    
}
