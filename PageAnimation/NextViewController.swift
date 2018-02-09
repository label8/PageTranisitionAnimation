//
//  NextViewController.swift
//  PageAnimation
//
//  Created by 蜂谷庸正 on 2018/02/09.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    var indexPath: IndexPath!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImageView.image = UIImage(named: "fukei\(indexPath.row)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
