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
    
    private var infoItems = Array<Any>()
    private var selectedInfoItemIndexes = Array<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initObserver()
        initData()
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
            if let infoItems = infoItems {
                self.infoItems = infoItems
            }
            self.cardCollectionView.reloadData()
            
            self.loadingIndicatorView.isHidden = true
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
        self.loadingIndicatorView.isHidden = false
        self.viewMode?.fetchShuffleInfoItems()
    }
}

extension ZooGameVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.infoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZooGameVC.CELL_ID, for: indexPath) as? ZooCardItemCell else {
            fatalError("Init cell fail")
        }
        
        let itemInfo = self.infoItems[indexPath.row]
        let isSelected = selectedInfoItemIndexes.contains(indexPath.row)
        
        switch itemInfo.self {
        case is AnimalInfoItem:
            let animalInfoItem = itemInfo as! AnimalInfoItem
            
            cell.update(isSelected: isSelected, picUrl: animalInfoItem.aPic01URL)
        case is PlantInfoItem:
            let plantInfoItem = itemInfo as! PlantInfoItem
            
            cell.update(isSelected: isSelected, picUrl: plantInfoItem.fPic01URL)
        default:
            cell.update(isSelected: false, picUrl: "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let gapSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(ZooGameVC.NO_OF_CELL_IN_ROW - 1))
        let size = (collectionView.bounds.width - gapSpace) / CGFloat(ZooGameVC.NO_OF_CELL_IN_ROW)
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 檢查是否已選過
        guard !self.selectedInfoItemIndexes.contains(indexPath.row) else {
            return
        }
        
        selectedInfoItemIndexes.append(indexPath.row)
        collectionView.reloadData()
    }
}
