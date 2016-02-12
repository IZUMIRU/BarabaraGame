//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 森泉亮介 on 2016/02/12.
//  Copyright © 2016年 森泉亮介. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //上の画像
    @IBOutlet var imgView1: UIImageView!
    //真ん中の画像
    @IBOutlet var imgView2: UIImageView!
    //下の画像
    @IBOutlet var imgView3: UIImageView!
    
    //スコアを表示するラベル
    @IBOutlet var resultLabel: UILabel!
    
    //画像を動かすためのタイマー、何秒後に何々をするということができる、制限時間やアニメーション
    var timer: NSTimer = NSTimer()
    //スコア保存
    var score: Int = 1000
    //スコアの保存をするための変数、keyとなる文字列を指定すれば同じアプリ内ならどこから呼び出しても同じ値と取得できる
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    //画面幅（UIScreen.mainScreen().bounds.sizeで現在のiphoneサイズを取得できる）
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width
    
    //画像の位置の配列、少数の配列
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    
    //画像の動かす幅の配列、少数の配列
    var dx: [CGFloat] = [1.0, 0.5, -1.0]
    
    
    func start() {
        //結果ラベルを見えなくする
        resultLabel.hidden = true
        
        //タイマーを動かす（タイマーによってメソッドupを呼び出す間隔0.005秒、tureで繰り返している）
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: "up", userInfo: nil, repeats: true)
        timer.fire()
    }
    
    
    func up() {
        for i in 0..<3 {
            //端にきたら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            //画像の位置をdx分ずらす
            positionX[i] += dx[i]
        }
        //上の画像をずらした位置に移動させる
        imgView1.center.x = positionX[0]
        //真ん中の画像をずらした位置に移動させる
        imgView2.center.x = positionX[1]
        //下の画像をずらした位置に移動させる
        imgView3.center.x = positionX[2]
    }
    
    
    //ストップ機能
    @IBAction func stop() {
        //もしタイマーが動いていたら
        if timer.valid == true {
            //タイマーを無効にする
            timer.invalidate()

            for i in 0..<3 {
                //真ん中から画像のずれた分だけスコアから値を引く
                score = score - abs(Int(width/2 - positionX[i]))*2
            }
            //結果ラベルにスコアを表示する
            resultLabel.text = "Score : " + String(score)
            //結果ラベルを隠さない(現す)
            resultLabel.hidden = false
            
            
            //スコアの保存
            //let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()で宣言
            //保存したいタイミングで defaults.setInteger(保存したい値, forKey: "キー") で保存
            //使用したいタイミングで defaults.integerForkey("キー") で保存した値を取り出す
            //キーの名前を変えることで何個も値を保存できる
            
            //ユーザーデフォルトに"score1""score2""score3"というキーの値を取得
            let highScore1: Int = defaults.integerForKey("score1")
            let highScore2: Int = defaults.integerForKey("score2")
            let highScore3: Int = defaults.integerForKey("score3")
            
            //ランキング1位の記録を更新したら
            if score > highScore1 {
                //"score1"というキーでscoreを保存
                defaults.setInteger(score, forKey: "score1")
                //"score2"というキーでhighscore(元1位の記録)を保存
                defaults.setInteger(highScore1, forKey: "score2")
                //"score3"というキーでhighscore(元2位の記録)を保存
                defaults.setInteger(highScore2, forKey: "score3")
            
            //ランキング2位の記録を更新したら
            } else if score > highScore2 {
                //"score2"というキーでscoreを保存
                defaults.setInteger(score, forKey: "score2")
                //"score3"というキーでhighscore(元2位の記録)を保存
                defaults.setInteger(highScore2, forKey: "score3")
            
            //ランキング3位の記録を更新したら
            } else if score > highScore3 {
                //"score3"というキーでscoreを保存
                defaults.setInteger(score, forKey: "score3")
            }
            defaults.synchronize()
        }
    }
    
    
    //リトライ機能
    @IBAction func retry() {
        //スコアの値をリセットする
        score = 1000
        //画像の位置を真ん中に戻す
        positionX = [width/2, width/2, width/2]
        //スタートメソッドを呼び出す
        self.start()
    }
    
    
    //Topへボタン
    @IBAction func toTop() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //最初に画面が呼ばれた時に画像の位置と動かす幅を設定しよう
    override func viewDidLoad() {
        //画像の位置を画面幅の中心にする
        positionX = [width/2, width/2, width/2]
        
        //前ページで書いたstartというメソッドを呼び出す
        self.start()
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
