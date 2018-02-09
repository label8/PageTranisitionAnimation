//
//  ViewController.swift
//  PageAnimation
//
//  Created by 蜂谷庸正 on 2018/02/09.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let fukeiImages = [
        "fukei0",
        "fukei1",
        "fukei2",
        "fukei3"
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "FukeiCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "fukeiCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fukeiCollectionViewCell", for: indexPath) as! FukeiCollectionViewCell
        let cellImage = UIImage(named: fukeiImages[indexPath.row])
        cell.imageView.image = cellImage
        cell.titleLabel.text = "ラベル - \(indexPath.row)"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NextViewController", bundle: nil)
        let naviVC = storyboard.instantiateInitialViewController() as! UINavigationController
        let nextVC = naviVC.topViewController as! NextViewController
        nextVC.indexPath = indexPath
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 113, height: 153)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}
