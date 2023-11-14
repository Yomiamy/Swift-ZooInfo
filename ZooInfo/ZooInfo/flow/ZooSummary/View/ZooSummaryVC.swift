//
//  ZoomSummaryVC.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/13.
//

import UIKit
import Kingfisher

class ZooSummaryVC: UIViewController {
    
    private static let CELL_ID = "zoo_summary_item_cell"
    
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet var tabTitles: [UILabel]!
    @IBOutlet var tabIndicators: [UIView]!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var categoryInfoView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var picUrl:String!
    var category:String!
    var info:String!
    
    private var zooInfoItems: [ZooInfoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initObserver()
        initData()
    }
    
    func initView() {
        // 初始外部參數內容
        self.picImageView.kf.setImage(with: URL(string: self.picUrl))
        self.categoryLabel.text = self.category
        self.infoLabel.text = self.info
        
        // 初始點選第一個tab
        self.resetTab()
        self.onTabCategoryClicked(nil)
        
        // 初始TableView
        self.itemTableView.register(UINib(nibName: "\(ZooSummaryItemCell.self)", bundle: nil), forCellReuseIdentifier: ZooSummaryVC.CELL_ID)
        self.itemTableView.dataSource = self
        self.itemTableView.delegate = self
    }
    
    func initObserver() {}
    
    func initData() {}
    
    private func resetTab() {
        tabTitles.forEach { tabTitle in
            tabTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        }
        
        tabIndicators.forEach { indicator in
            indicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            indicator.isHidden = true
        }
        
        self.categoryInfoView.isHidden = true
        self.itemTableView.isHidden = true
    }
    
    
    @IBAction func onTabCategoryClicked(_ sender: Any?) {
        self.resetTab()
        self.tabTitles[0].textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabIndicators[0].isHidden = false
        self.categoryInfoView.isHidden = false
        
        print("")
    }
    
    @IBAction func onTabAnimalClicked(_ sender: Any?) {
        self.resetTab()
        self.tabTitles[1].textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabIndicators[1].isHidden = false
        self.itemTableView.isHidden = false
        
        print("")
    }
    
    
    @IBAction func onTabPlantClicked(_ sender: Any?) {
        self.resetTab()
        self.tabTitles[2].textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabIndicators[2].isHidden = false
        self.itemTableView.isHidden = false
        
        print("")
    }
}


extension ZooSummaryVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.zooCategoryItems.count
        // TODO: No data
        0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ZooSummaryVC.CELL_ID, for: indexPath) as? ZooSummaryItemCell else { fatalError("Init cell fail") }
        
        let infoItem = self.zooInfoItems[indexPath.row]
        // TODO: Need double check data format
        cell.update(picUrl: infoItem.aPic01URL,
                    name: infoItem.aNameCh,
                    info: infoItem.aSummary,
                    memo: infoItem.aPhylum)
        
        return cell
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
