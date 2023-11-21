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
    
    func fetchShuffleInfoItems() {
        self.repository?.fetchAllInfo { [unowned self] animalInfoItems, plantInfoItems in
            var selectedInfoItems = Array<Any>()
            let shuffledAnimalInfoItems = animalInfoItems?.shuffled() ?? []
            let shuffledPlantInfoItems = plantInfoItems?.shuffled() ?? []
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
        } onFail: { [unowned self]  error in
            self.error.data = error.localizedDescription
        }
    }
    
}
