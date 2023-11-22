//
//  ZooGameViewModel.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/21.
//

import Foundation
import ETBinding

class ZooGameViewModel: BaseViewModel<ZooSummaryRepository> {
    
    private static let TOTAL_SELECTED_TYPE_COUNT = 6
    
    var selectedInfoItems: LiveData<(Array<Any>?)> = LiveData(data: nil)
    var error: LiveData<String?> = LiveData(data: nil)
    
    private var animalInfoItems:[AnimalInfoItem]? = nil
    private var plantInfoItems:[PlantInfoItem]? = nil
    
    func fetchCardInfo() {
        if(self.animalInfoItems == nil || self.plantInfoItems == nil) {
            self.repository?.fetchAllInfo { [unowned self] animalInfoItems, plantInfoItems in
                self.animalInfoItems = animalInfoItems
                self.plantInfoItems = plantInfoItems
                
                self.selectShuffleInfoItems()
            } onFail: { [unowned self]  error in
                self.error.data = error.localizedDescription
            }
        } else {
            // 若已有既有緩存則直接選擇
            self.selectShuffleInfoItems()
        }
        
    }
    
    private func selectShuffleInfoItems() {
        var selectedInfoItems = Array<Any>()
        let shuffledAnimalInfoItems = self.animalInfoItems!.shuffled()
        let shuffledPlantInfoItems = self.plantInfoItems!.shuffled()
        let halfCount = ZooGameViewModel.TOTAL_SELECTED_TYPE_COUNT / 2
        
        // 動, 植物個選3種
        for i in 0..<halfCount {
            selectedInfoItems.append(contentsOf: [
                shuffledAnimalInfoItems[i],
                shuffledAnimalInfoItems[i],
                shuffledPlantInfoItems[i],
                shuffledPlantInfoItems[i]])
        }
        self.selectedInfoItems.data = selectedInfoItems.shuffled()
    }
    
    func checkIsSameInfo(item1: Any, item2: Any) -> Bool {
        if item1.self is AnimalInfoItem,
           item2.self is AnimalInfoItem {
            let animalInfoItem1 = item1 as! AnimalInfoItem
            let animalInfoItem2 = item2 as! AnimalInfoItem
            
            return animalInfoItem1.aNameEn == animalInfoItem2.aNameEn
        } else if item1.self is PlantInfoItem,
                  item2.self is PlantInfoItem {
            let plantInfoItem1 = item1 as! PlantInfoItem
            let plantInfoItem2 = item2 as! PlantInfoItem
            
            return plantInfoItem1.fNameEn == plantInfoItem2.fNameEn
        }
        
        return false
    }
    
    override func onClear() {
        super.onClear()
        
        self.animalInfoItems = nil
        self.plantInfoItems = nil
    }
}
