//
//  ZooCategoryViewController.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/11.
//

import UIKit
import ETBinding

class ZooCategoryVC: UIViewController {
    
    private static let SEGUE_ID = "goToSummary"
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
    
        // 回復TabBar顯示
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender data: Any?) {
        guard let destinationVC = segue.destination as? ZooSummaryVC, 
                let selectedIndexPath = self.zooCategoryTableView.indexPathForSelectedRow else {
            
            return
        }
        
        let zooCategoryInfoItem = self.zooCategoryItems[selectedIndexPath.row]
        self.zooCategoryTableView.deselectRow(at: selectedIndexPath, animated: true)
        
        // 隱藏TabBar當Push到下一頁時
        destinationVC.hidesBottomBarWhenPushed = true
        destinationVC.picUrl = zooCategoryInfoItem.ePicURL
        destinationVC.category = zooCategoryInfoItem.eCategory
        destinationVC.info = zooCategoryInfoItem.eInfo
    }
    
    private func initView() {
        self.navigationItem.title = "臺北市立動物園"
        
        // 初始Loading Indicator
        self.loadingIndicatorView.style = .large
        self.loadingIndicatorView.startAnimating()
        
        // 初始RefreshController
        self.refreshController.attributedTitle = NSAttributedString(string:  "刷新中...")
        self.refreshController.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        // 初始TableView
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
        performSegue(withIdentifier: ZooCategoryVC.SEGUE_ID, sender: nil)
    }
}
