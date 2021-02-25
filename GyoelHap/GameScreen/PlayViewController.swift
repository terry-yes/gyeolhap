//
//  PlayViewController.swift
//  GyeolHap
//
//  Created by Terry Lee on 2021/02/03.
//

import UIKit

class PlayViewController: UIViewController {
//    let stageManager = StageManager.shared

    @IBOutlet weak var collectionViewUp: UICollectionView!
    @IBOutlet weak var collectionViewDown: UICollectionView!
    @IBOutlet weak var gyeolImage: UIImageView!
    @IBOutlet weak var GyeolButton: UIButton!
    
    var currentStage: Stage?
    var currentStageManager: CurrentStageManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        collectionViewUp.delegate = self
        collectionViewUp.dataSource = self
        
        collectionViewDown.delegate = self
        collectionViewDown.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let item = currentStage else { return }
        self.currentStageManager = CurrentStageManager(stage: item)
        print("정답리스트: \((currentStageManager?.answers)!)")
    }
}

extension PlayViewController: UICollectionViewDataSource {

    //셀을 몇개 보여줄까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewUp {
            return 9
        } else {
            return 12
        }
    }
    
    //컬렉션 뷰 셀 어떻게 보여줄까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewUp {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TileCollectionViewCell", for: indexPath) as? TileCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(index: indexPath.item, item: currentStage?.dataArray[indexPath.item] ?? 0)
            cell.tapHandler = {
                guard let manager = self.currentStageManager else { return }
                manager.addToTryList(indexPath.item + 1)
                manager.printTryList()
            }
            cell.isClicked = {
                //TODO: manager 옵셔널 바인딩을 실패했을 때 return false부분이 맞는지 알아보고 바꾸기
                guard let manager = self.currentStageManager else { return [] }
                return manager.tryList
            }
            //리로드하면 랜덤하게 색칠됨
//            cell.reloadView = {
//                self.collectionViewUp.reloadData()
//            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath) as? AnswerCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}


//extension PlayViewController: UICollectionViewDelegate {
//    //클릭했을 때 동작
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
//}

extension PlayViewController:UICollectionViewDelegateFlowLayout {
    //셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewUp {
            let inset: CGFloat = 10
            let width: CGFloat = (collectionView.bounds.width - inset * 4) / 3
            let height: CGFloat = (collectionView.bounds.height - inset * 4) / 3
            return CGSize(width:width, height: height)
        } else {
            let inset: CGFloat = 0
            let width: CGFloat = (collectionView.bounds.width - inset * 3) / 2
            let height: CGFloat = (collectionView.bounds.height - inset * 7) / 6
            return CGSize(width:width, height: height)
        }
    }
}
