//
//  stageManager.swift
//  GyeolHap
//
//  Created by Terry Lee on 2021/02/10.
//

import UIKit

class StageManager {
    static let shared = StageManager()
    
    var newStages:[NewStage] = []
    let stageCount: Int = 20
    var currentStageId: Int?
    var currentStage: NewStage?
    
    init() {
        self.newStages = createRawStages(size: stageCount)

    }
    
    func createRawStages(size: Int) -> [NewStage] {
        var newRawStages: [NewStage] = []
        
        for i in 1...size {
            let rawStage = NewStage(id: i, dataArray: nineRandomNumberFrom0To26())
            newRawStages.append(rawStage)
        }
        return newRawStages
    }
    
    func nineRandomNumberFrom0To26() -> Array<Int> {
        let sequence = 0 ..< 27
        let shuffledSequence = sequence.shuffled()
        return Array(shuffledSequence[0...8])
    }
     
    func stage(at index: Int) -> NewStage? {
        return newStages[index]
    }
    
    func replaceCurrentStage(with item: NewStage?){
        self.currentStage = item
    }
}
