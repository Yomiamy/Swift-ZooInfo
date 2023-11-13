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
    private let refreshController: UIRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initObserver()
        initData(isReload: false)
    }
    
    private func initView() {
        self.navigationItem.title = "臺北市立動物園"
        
        self.loadingIndicatorView.style = .large
        self.loadingIndicatorView.startAnimating()
        
        self.refreshController.attributedTitle = NSAttributedString(string:  "刷新中...")
        self.refreshController.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        self.zooCategoryTableView.addSubview(refreshController)
        self.zooCategoryTableView.register(UINib(nibName: "\(ZooCategoryItemCell.self)", bundle: nil), forCellReuseIdentifier: ZooCategoryVC.CELL_ID)
        self.zooCategoryTableView.dataSource = self
        self.zooCategoryTableView.delegate = self
    }
    
    private func initObserver() {
        self.viewMode.zooCategoryItems.observe(owner: self) { [unowned self] (zooCategoryItems:[ZooCategoryInfoItem]?) in
            self.loadingIndicatorView.isHidden = true
            self.refreshController.endRefreshing()
            
            guard zooCategoryItems != nil else {
                print("zooCategoryItems is nil")
                return
            }
            
            self.zooCategoryItems = zooCategoryItems!
            self.zooCategoryTableView.reloadData()
        }
        
        self.viewMode.error.observe(owner: self) { [unowned self] errorTuple in
            self.loadingIndicatorView.isHidden = true
            self.refreshController.endRefreshing()
            
            guard errorTuple != nil else {
                return
            }
            
            let (errorCode, errorDescription) = errorTuple!
            // TODO: Not implemented
            print("")
        }
    }
    
    private func initData(isReload: Bool) {
        if(!isReload) {
            self.loadingIndicatorView.isHidden = false
            
        }
        self.viewMode.fetchZooCategory()
    }
    
    @objc private func reload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            self.initData(isReload: true)
        }
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