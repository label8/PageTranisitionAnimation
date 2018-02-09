//
//  CustomTransitionController.swift
//  PageAnimation
//
//  Created by 蜂谷庸正 on 2018/02/09.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class CustomTransitionController: NSObject {
    let duration: TimeInterval = 0.8
    var isForward: Bool = false
}

extension CustomTransitionController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isForward {
            // Pushアニメーション
            forwardTransition(transitionContext: transitionContext)
        } else {
            // Popアニメーション
            backwardTransition(transitionContext: transitionContext)
        }
    }
    
    // 遷移時のTransition処理
    private func forwardTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 遷移元、遷移先、遷移コンテナの取得
        let fromVC = transitionContext.viewController(forKey: .from) as! ViewController
        let toVC   = transitionContext.viewController(forKey: .to) as! NextViewController
        let containerView = transitionContext.containerView
        
        // 遷移元のセルを取得
        let cell: FukeiCollectionViewCell = fromVC.collectionView.cellForItem(at: (fromVC.collectionView.indexPathsForSelectedItems?.first)!) as! FukeiCollectionViewCell
        // 遷移元のセルのイメージビューからアニメーション用のビューを作成
        let animationView = UIImageView(image: cell.imageView.image)
        animationView.frame = containerView.convert(cell.imageView.frame, from: cell.imageView.superview)
        // 遷移元のセルのイメージビューを非表示にする
        cell.imageView.isHidden = true
        
        // 遷移後のビューコントローラーを予め最後の位置まで移動完了させ非表示にする
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        // 遷移後のイメージはアニメーションが完了するまで非表示にする
        toVC.mainImageView.isHidden = true
        
        // 遷移コンテナに遷移後のビューとアニメーション用のビューを追加する
        containerView.addSubview(toVC.view)
        containerView.addSubview(animationView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // 遷移後のビューを徐々に表示する
            toVC.view.alpha = 1.0
            // アニメーション用のビューを遷移後のイメージの位置までアニメーションする
            animationView.frame = containerView.convert(toVC.mainImageView.frame, from: toVC.view)
        }, completion: { finished in
            // 遷移後のイメージを表示する
            toVC.mainImageView.isHidden = false
            // セルのイメージの非表示を元に戻す
            cell.imageView.isHidden = false
            // アニメーション用のビューを削除する
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
    // 復帰時のTransition処理
    private func backwardTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 遷移元、遷移先、遷移コンテナの取得
        let fromVC = transitionContext.viewController(forKey: .from) as! NextViewController
        let toVC   = transitionContext.viewController(forKey: .to) as! ViewController
        let containerView = transitionContext.containerView
        
        // 遷移元のイメージビューからアニメーション用のビューを作成
        let animationView = fromVC.mainImageView.snapshotView(afterScreenUpdates: false)
        animationView?.frame = containerView.convert(fromVC.mainImageView.frame, from: fromVC.mainImageView.superview)
        // 遷移元のイメージを非表示にする
        fromVC.mainImageView.isHidden = true
        
        // 遷移先のセルを取得
        let cell: FukeiCollectionViewCell = toVC.collectionView.cellForItem(at: fromVC.indexPath) as! FukeiCollectionViewCell
        // 遷移先のセルイメージを非表示
        cell.imageView.isHidden = true
        // 遷移後のビューコントローラーを予め最後の位置まで移動完了させ非表示にする
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        // 遷移コンテナに遷移後のビューとアニメーション用のビューを追加する
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(animationView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // 遷移元のビューを徐々に非表示にする
            fromVC.view.alpha = 0
            // アニメーションビューは遷移後のイメージの位置までアニメーションする
            animationView?.frame = containerView.convert(cell.imageView.frame, from: cell.imageView.superview)
        }, completion: { finished in
            // アニメーション用のビューを削除する
            animationView?.removeFromSuperview()
            // 遷移元のイメージの非表示を元に戻す
            fromVC.mainImageView.isHidden = false
            // セルのイメージの非表示を元に戻す
            cell.imageView.isHidden = false
            transitionContext.completeTransition(true)
        })
    }
    
}
