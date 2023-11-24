//
//  ZooGameVC.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/21.
//

import UIKit

class ZooGameVC: BaseVC<ZooGameViewModel, ZooSummaryRepository> {
    
    private static let NO_OF_CELL_IN_ROW = 3
    private static let NO_OF_ROW = 4
    private static let CELL_ID = "zoo_card_item_cell"

    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var timerLabel: UILabel!
    
    private var timer:Timer? = nil
    private var timeCounterInSec = 0
    // 所有要顯示的項目
    private var infoItems = Array<Any>()
    // 需要被翻開牌的索引陣列
    private var openedInfoItemIndexes = Array<Int>()
    // 已配對相同的索引陣列
    private var pairedInfoItemIndexes = Array<Int>()
    // 最新被翻開牌的索引
    private var newOpenedIndex: Int? = nil
    // 是否可點擊項目
    private var isItemSelectable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.resetStatus()
        self.viewMode?.onClear()
    }
    
    private func initView() {
        // 初始Loading Indicator
        self.loadingIndicatorView.style = .large
        self.loadingIndicatorView.startAnimating()
        
        // 初始CollectionView
        self.cardCollectionView.register(UINib(nibName: "\(ZooCardItemCell.self)", bundle: nil), forCellWithReuseIdentifier: ZooGameVC.CELL_ID)
        self.cardCollectionView.dataSource = self
        self.cardCollectionView.delegate = self
    }
    
    private func initObserver() {
        self.viewMode?.selectedInfoItems.observe(owner: self) { infoItems in
            self.loadingIndicatorView.isHidden = true
            
            if let infoItems = infoItems {
                self.infoItems = infoItems
            }
            self.cardCollectionView.reloadData()
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                self.timeCounterInSec += 1
                
                let minutes = self.timeCounterInSec / 60
                let seconds = self.timeCounterInSec % 60
                let counterStr = String(format: "%02d:%02d", minutes, seconds)
                self.timerLabel.text = "計時:\(counterStr)"
            })
        }
        
        self.viewMode?.error.observe(owner: self) { [unowned self] errorMsg in
            self.loadingIndicatorView.isHidden = true
            
            guard let errorMsg = errorMsg else {
                return
            }
            
            // TODO: Not implemented
            print("")
        }
    }
    
    private func initData() {
        self.resetStatus()
        
        self.loadingIndicatorView.isHidden = false
        self.viewMode?.fetchCardInfo()
    }
    
    private func resetStatus() {
        self.loadingIndicatorView.isHidden = true
        self.isItemSelectable = true
        self.newOpenedIndex = nil
        
        self.openedInfoItemIndexes.removeAll()
        self.pairedInfoItemIndexes.removeAll()
        self.infoItems.removeAll()
        self.cardCollectionView.reloadData()
        
        self.timeCounterInSec = 0
        self.timer?.invalidate()
        self.timerLabel.text = "計時:00:00"
    }
    
    @IBAction func onRetryClicked(_ sender: Any) {
        initData()
    }
}

extension ZooGameVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.infoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZooGameVC.CELL_ID, for: indexPath) as? ZooCardItemCell else {
            fatalError("Init cell fail")
        }
        
        let itemInfo = self.infoItems[indexPath.row]
        let isNeedOpen = self.openedInfoItemIndexes.contains(indexPath.row)
        let isNewOpened = (self.newOpenedIndex == indexPath.row)
        let isPaired = self.pairedInfoItemIndexes.contains(indexPath.row)
        
        switch itemInfo.self {
        case is AnimalInfoItem:
            let animalInfoItem = itemInfo as! AnimalInfoItem
            
            cell.update(isNewOpened: isNewOpened,
                        isNeedOpen: isNeedOpen,
                        isPaired: isPaired,
                        name: animalInfoItem.aNameCh,
                        picUrl: animalInfoItem.aPic01URL)
        case is PlantInfoItem:
            let plantInfoItem = itemInfo as! PlantInfoItem
            
            cell.update(isNewOpened: isNewOpened,
                        isNeedOpen: isNeedOpen,
                        isPaired: isPaired,
                        name: plantInfoItem.fNameCh,
                        picUrl: plantInfoItem.fPic01URL)
        default:
            cell.update(isNewOpened: false,
                        isNeedOpen: false,
                        isPaired: false,
                        name: "",
                        picUrl: "")
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 檢查是否已選過或已配對
        guard !self.openedInfoItemIndexes.contains(indexPath.row), !self.pairedInfoItemIndexes.contains(indexPath.row) else {
            return
        }
        
        
        if newOpenedIndex == nil {
            self.newOpenedIndex = indexPath.row
            
            self.openedInfoItemIndexes.append(indexPath.row)
            self.cardCollectionView.reloadData()
        } else {
            let oldOpenedIndex = self.newOpenedIndex
            self.newOpenedIndex = indexPath.row
            
            self.openedInfoItemIndexes.append(indexPath.row)
            self.cardCollectionView.reloadData()
            
            self.isItemSelectable = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard let oldOpenedIndex = oldOpenedIndex, let newOpenedIndex = self.newOpenedIndex else {
                    return
                }
                
                let isSameInfo = self.viewMode?.checkIsSameInfo(item1: self.infoItems[newOpenedIndex], item2: self.infoItems[oldOpenedIndex]) ?? false
                
                if isSameInfo {
                    self.pairedInfoItemIndexes.append(self.newOpenedIndex!)
                    self.pairedInfoItemIndexes.append(oldOpenedIndex)
                    
                    // 全配對完則停止
                    if(self.pairedInfoItemIndexes.count == self.infoItems.count) {
                        self.displayAlert(title: "完成", msg: "太棒了!你已經完成所有卡片配對~")
                        self.timer?.invalidate()
                    }
                }
                
                self.openedInfoItemIndexes.removeAll { index in
                    index == oldOpenedIndex || index == newOpenedIndex
                }
                
                self.isItemSelectable = true
                self.newOpenedIndex = nil
                self.cardCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.isItemSelectable
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let gapSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(ZooGameVC.NO_OF_CELL_IN_ROW - 1))
        let size = (collectionView.bounds.width - gapSpace) / CGFloat(ZooGameVC.NO_OF_CELL_IN_ROW)
        
        return CGSize(width: size, height: size)
    }
}
