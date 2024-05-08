//
//  BookListVC.swift
//  ch5_BookApp
//
//  Created by 한철희 on 5/7/24.
//

import UIKit

class BookListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        label.text = "SeconView"
        view.addSubview(label)
    }


}
