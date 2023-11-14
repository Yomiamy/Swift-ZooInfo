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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet var loadingIndicatorView: UIActivityIndicatorView!
    
    var picUrl:String!
    var name:String!
    var info:String!
    
    private let viewMode: ZooSummaryViewModel = ZooSummaryViewModel()
    private var animalInfoItems: [AnimalInfoItem] = []
    private var plantInfoItems: [PlantInfoItem] = []
    private var isAnimalOrPlant = 0 // 0: Animal, 1: Plant
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initObserver()
        initData()
    }
    
    func initView() {
        // 初始Loading Indicator
        self.loadingIndicatorView.style = .large
        self.loadingIndicatorView.startAnimating()
        
        // 初始外部參數內容
        self.picImageView.kf.setImage(with: URL(string: self.picUrl))
        self.nameLabel.text = self.name
        self.infoLabel.text = self.info
        
        // 初始點選第一個tab
        self.resetTab()
        self.onTabCategoryClicked(nil)
        
        // 初始TableView
        self.itemTableView.register(UINib(nibName: "\(ZooSummaryItemCell.self)", bundle: nil), forCellReuseIdentifier: ZooSummaryVC.CELL_ID)
        self.itemTableView.dataSource = self
        self.itemTableView.delegate = self
    }
    
    func initObserver() {
        self.viewMode.animalInfoItems.observe(owner: self) { [unowned self] (animalInfoItems:[AnimalInfoItem]?) in
            guard animalInfoItems != nil else {
                print("animalInfoItems is nil")
                return
            }
            
            self.animalInfoItems = animalInfoItems!
        }
        
        self.viewMode.plantInfoItems.observe(owner: self) { [unowned self] (plantInfoItems:[PlantInfoItem]?) in
            self.loadingIndicatorView.isHidden = true
            
            guard plantInfoItems != nil else {
                print("animalInfoItems is nil")
                return
            }
            
            self.plantInfoItems = plantInfoItems!
        }
    }
    
    func initData() {
        self.loadingIndicatorView.isHidden = false
        self.viewMode.fetchAllInfo(location: self.name)
    }
    
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
        self.isAnimalOrPlant = 0
        
        self.itemTableView.reloadData()
    }
    
    
    @IBAction func onTabPlantClicked(_ sender: Any?) {
        self.resetTab()
        self.tabTitles[2].textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabIndicators[2].isHidden = false
        self.itemTableView.isHidden = false
        self.isAnimalOrPlant = 1
        
        self.itemTableView.reloadData()
    }
}


extension ZooSummaryVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.isAnimalOrPlant == 0 ? self.animalInfoItems.count : self.plantInfoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ZooSummaryVC.CELL_ID, for: indexPath) as? ZooSummaryItemCell else { fatalError("Init cell fail") }
        
        if(self.isAnimalOrPlant == 0) {
            let infoItem = self.animalInfoItems[indexPath.row]
            cell.update(picUrl: infoItem.aPic01URL,
                        name: infoItem.aNameCh,
                        info: infoItem.aFeature,
                        memo: infoItem.aFamily)
            return cell
        } else {
            let infoItem = self.plantInfoItems[indexPath.row]
            cell.update(picUrl: infoItem.fPic01URL,
                        name: infoItem.fNameCh,
                        info: infoItem.fFeature,
                        memo: infoItem.fFamily)
            return cell
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
