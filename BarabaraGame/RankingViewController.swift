//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by 森泉亮介 on 2016/02/12.
//  Copyright © 2016年 森泉亮介. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    
    //スコアを保存するための変数
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //1位のスコアを表示するラベル
    @IBOutlet var rankingLabel1: UILabel!
    //2位のスコアを表示するラベル
    @IBOutlet var rankingLabel2: UILabel!
    //3位のスコアを表示するラベル
    @IBOutlet var rankingLabel3: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //"score1"というキーの値を取得して表示する
        rankingLabel1.text = String(defaults.integerForKey("score1"))
        //"score2"というキーの値を取得して表示する
        rankingLabel2.text = String(defaults.integerForKey("score2"))
        //"score3"というキーの値を取得して表示する
        rankingLabel3.text = String(defaults.integerForKey("score3"))
    }
    
    
    //Topへボタン
    @IBAction func toTop() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
