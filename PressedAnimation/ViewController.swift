//
//  ViewController.swift
//  PressedAnimation
//
//  Created by Dongwan Ryoo on 11/24/24.
//

import UIKit

import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    let dataSource = Model.mock()
    
    lazy var tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.delegate = self
        view.dataSource = self
        view.register(PressedCell.self, forCellReuseIdentifier: PressedCell.description())
        view.rowHeight = 60

        
        return view
    }()
    
    let button = {
        let view = PressedButton()
        view.backgroundColor = .white
        view.setTitle("버튼", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(button)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(tableView.snp.bottom).offset(-100)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PressedCell.description(), for: indexPath) as? PressedCell else {
            return UITableViewCell()
        }
        
        let model = dataSource[indexPath.row]
        cell.setDataSource(model)
        
        return cell
    }
}

