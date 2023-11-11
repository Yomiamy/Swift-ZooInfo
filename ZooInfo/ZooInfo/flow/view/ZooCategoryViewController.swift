//
//  ZooCategoryViewController.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import UIKit

class ZooCategoryViewController: UIViewController {
    
    private static let CELL_ID = "zoo_category_item_cell"
    
    @IBOutlet weak var zooCategoryTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initView()
        initData()
        initObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func initView() {
        self.zooCategoryTableView.register(UINib(nibName: "\(ZooCategoryItemCell.self)", bundle: nil), forCellReuseIdentifier: ZooCategoryViewController.CELL_ID)
        self.zooCategoryTableView.dataSource = self
        self.zooCategoryTableView.delegate = self
    }
    
    private func initData() {
        
    }
    
    private func initObserver() {
        
    }
}

extension ZooCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ZooCategoryViewController.CELL_ID, for: indexPath) as? ZooCategoryItemCell else { fatalError("Init cell fail") }
        
        // TODO: 測試資料
        let zooCategoryInfoItem = ZooCategoryInfoItem(id: 111,
                                                      eNo: "",
                                                      eCategory: "",
                                                      eName: "動物1",
                                                      ePicURL: "https://www.zoo.gov.tw/iTAP/03_Animals/RainForest/AsianElephant/AsianElephant_Pic01.jpg",
                                                      eInfo: "描述一",
                                                      eMemo: "週一館休",
                                                      eGeo: "",
                                                      eURL: "")
        cell.update(picUrl: zooCategoryInfoItem.ePicURL,
                    name: zooCategoryInfoItem.eName,
                    info: zooCategoryInfoItem.eInfo,
                    memo: zooCategoryInfoItem.eMemo)
        
        return cell
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
