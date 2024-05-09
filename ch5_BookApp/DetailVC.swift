//
//  DetailVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/9/24.
//

import UIKit

class DetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 레이블 인스턴스 생성
        let modalLabel = UILabel()
        
        // 레이블에 텍스트 설정
        modalLabel.text = "모달뷰입니다"
        
        // 레이블의 텍스트 정렬 설정
        modalLabel.textAlignment = .center
        
        // 레이블의 배경색 설정 (옵션)
        modalLabel.backgroundColor = .lightGray // 배경색은 선택사항입니다.
        
        // 오토레이아웃을 사용하기 위해 false로 설정
        modalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰의 서브뷰로 추가
        view.addSubview(modalLabel)
        
        // 레이블의 중앙 위치를 부모 뷰의 중앙과 일치시키기 위한 제약 조건 설정
        NSLayoutConstraint.activate([
            modalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

