//
//  ZooCategoryViewController.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import UIKit
import ETBinding

class ZooCategoryVC: UIViewController {
    
    private static let CELL_ID = "zoo_category_item_cell"
    
    @IBOutlet weak var zooCategoryTableView: UITableView!
    @IBOutlet var loadingIndicatorView: UIActivityIndicatorView!
    
    private let viewMode: ZooCategoryViewModel = ZooCategoryViewModel()
    private var zooCategoryItems: [ZooCategoryInfoItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initObserver()
        initData()
    }
    
    private func initView() {
        self.navigationItem.title = "臺北市立動物園"
        
        self.loadingIndicatorView.style = .large
        self.loadingIndicatorView.startAnimating()
        
        self.zooCategoryTableView.register(UINib(nibName: "\(ZooCategoryItemCell.self)", bundle: nil), forCellReuseIdentifier: ZooCategoryVC.CELL_ID)
        self.zooCategoryTableView.dataSource = self
        self.zooCategoryTableView.delegate = self
    }
    
    private func initObserver() {
        self.viewMode.zooCategoryItems.observe(owner: self) { (zooCategoryItems:[ZooCategoryInfoItem]?) in
            self.loadingIndicatorView.isHidden = true
            
            guard zooCategoryItems != nil else {
                print("zooCategoryItems is nil")
                return
            }
            
            self.zooCategoryItems = zooCategoryItems!
            self.zooCategoryTableView.reloadData()
        }
        
        self.viewMode.error.observe(owner: self) { errorTuple in
            self.loadingIndicatorView.isHidden = true
            
            guard errorTuple != nil else {
                return
            }
            
            let (errorCode, errorDescription) = errorTuple!
            // TODO: Not implemented
            print("")
        }
    }
    
    private func initData() {
        self.loadingIndicatorView.isHidden = false
        self.viewMode.fetchZooCategory()
    }
}

extension ZooCategoryVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.zooCategoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ZooCategoryVC.CELL_ID, for: indexPath) as? ZooCategoryItemCell else { fatalError("Init cell fail") }
        
        let zooCategoryInfoItem = self.zooCategoryItems[indexPath.row]
        cell.update(picUrl: zooCategoryInfoItem.ePicURL,
                    name: zooCategoryInfoItem.eName,
                    info: zooCategoryInfoItem.eInfo,
                    memo: zooCategoryInfoItem.eMemo.isEmpty ? "無休館資訊" : zooCategoryInfoItem.eMemo)
        
        return cell
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
