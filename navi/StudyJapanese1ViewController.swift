//
//  StudyJapanese1ViewController.swift
//  navi
//
//  Created by student on 2019/09/13.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class StudyJapanese1ViewController: UIViewController,AVAudioPlayerDelegate {
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var four: UIImageView!
    @IBOutlet weak var five: UIImageView!

    @IBOutlet weak var sel1: UIImageView!
    @IBOutlet weak var sel2: UIImageView!
    @IBOutlet weak var sel3: UIImageView!
    @IBOutlet weak var sel4: UIImageView!
    @IBOutlet weak var sel5: UIImageView!
    @IBOutlet weak var sel6: UIImageView!
    @IBOutlet weak var sel7: UIImageView!

    @IBOutlet weak var timerCountLabel: UILabel!
    @IBOutlet weak var nokori: UIProgressView!
    @IBOutlet weak var irasuto: UIImageView!
    
     var player : AVAudioPlayer?
    
    var chose: [String] = ["","","","","",""]
    var wordone = "Q"
    var wordtwo = "Q"
    var wordthree = "Q"
    var wordfour = "Q"
    var wordfive = "Q"
    var wordNokori = 0
    var firstSwitch = 0
    var progress:Float = 1
    var seikaimati = 0
    var wordlen = 0
    var word = ""
    
    //タイマークラスのインスタンスを生成
    var timer = Timer()
    //count変数に初期値0を代入
    var count = 60
    
    
    @IBOutlet weak var maru: UIImageView!
    
    override func viewDidLoad() {
        maru.isHidden = true
        nokori.transform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        nokori.progress = progress
        timerCountLabel.text = String(count)
        if count <= 10{
            nokori.progressTintColor = UIColor.red
            timerCountLabel.textColor = UIColor.red
        }
        if firstSwitch == 0{

            //invalidateメソッドはオブジェクトからタイマーを削除する
            timer.invalidate()
            Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(StudyJapanese1ViewController.updateTimer),
                                         userInfo: nil, repeats: true)
                firstSwitch = 1
            
        }
        
        

        
        super.viewDidLoad()
        mojibyoug()
        
        
        // Do any additional setup after loading the view.
        

    }
    

    
    
    func mojibyoug(){
        
        var selemoji: [String] = ["","","","","","","",""]
        let siriwords:[String] = ["AAIISU","IISU","UUSAGI","EENOGU","OONIGIRI","KAEERU","KITUNE","KURUMA","KEIISATU","KOAARA","SARU","SISO","SUSI","SEMI","SOBA","TAKO","TI00ZU","TUKI","TEREBI","TOKEII","NASU","NIKU","NUIIGURUMI","NEKO","NORI","HABURASI","HIMO","HUUUSENN","HEBI","HOTARU","MAKURA","MIZU","MUSIKAGO","MEDAKA","MORI","YAGI","YUKI","YOLLTO","RANNDOSERU","RINNGO","RU00RELLTO","REIIZOUUKO","ROUUSOKU","WATAGASI"]
        //2文字から５文字の単語
        
        let random:Int = Int(arc4random_uniform(43))
        
        word = siriwords[random]
        print(word)
        //let wordoo: NSString = word as NSString
        
        wordlen = word.count / 2
        wordNokori = wordlen
        print(wordlen)
        
        wordone = String(word[word.index(word.startIndex, offsetBy: 0)..<word.index(word.startIndex, offsetBy: 2)])
        var image = UIImage(named: "パネル" + wordone )
        one.image = image
        selemoji[1] = wordone
        
        if Int(wordlen) > 1 {
            wordtwo = String(word[word.index(word.startIndex, offsetBy: 2)..<word.index(word.startIndex, offsetBy: 4)])
            image = UIImage(named: "パネル" + wordtwo )
            two.image = image
            selemoji[2] = wordtwo
        }
        
        if wordlen > 2 {
            wordthree = String(word[word.index(word.startIndex, offsetBy: 4)..<word.index(word.startIndex, offsetBy: 6)])
            image = UIImage(named: "パネル" + wordthree )
            three.image = image
            selemoji[3] = wordthree
        }
        
        if wordlen > 3 {
            wordfour = String(word[word.index(word.startIndex, offsetBy: 6)..<word.index(word.startIndex, offsetBy: 8)])
            image = UIImage(named: "パネル" + wordfour )
            four.image = image
            selemoji[4] = wordfour
        }
        
        if wordlen > 4 {
            wordfive = String(word[word.index(word.startIndex, offsetBy: 8)..<word.index(word.startIndex, offsetBy: 10)])
            image = UIImage(named: "パネル" + wordfive )
            five.image = image
            selemoji[5] = wordfive
        }
        
        //選択肢表示
        var damilen: Int
        damilen = 7 - wordlen
        let nihongo:[String] = ["AA","II","UU","EE","OO","KA","KI","KU","KE","KO","SA","SI","SU","SE","SO","TA","TI","TU","TE","TO","NA","NI","NU","NE","NO","HA","HI","HU","HE","HO","MA","MI","MU","ME","MO","YA","YU","YO","RA","RI","RU","RE","RO","WA","WO","NN","GA","GI","GU","GE","GO","ZA","ZI","ZU","ZE","ZO","DA","DI","DU","DE","DO","BA","BI","BU","BE","BO","PA","PI","PU","PE","PO"]
        
        
        var int = Int.random(in: 0..<nihongo.count)
        while nihongo[int] == wordone || nihongo[int] == wordtwo || nihongo[int] == wordthree || nihongo[int] == wordfour || nihongo[int] == wordfive || nihongo[int] == wordfive {
            int = Int.random(in: 0..<nihongo.count)
        }
        selemoji[7] = nihongo[int]
        while  nihongo[int] == wordone || nihongo[int] == wordtwo || nihongo[int] == wordthree || nihongo[int] == wordfour || nihongo[int] == wordfive || nihongo[int] == wordfive || nihongo[int] == selemoji[7]{
            int = Int.random(in: 0..<nihongo.count)
        }
        selemoji[6] = nihongo[int]
        
        if damilen > 2 {
            while nihongo[int] == wordone || nihongo[int] == wordtwo || nihongo[int] == wordthree || nihongo[int] == wordfour || nihongo[int] == wordfive || nihongo[int] == wordfive || nihongo[int] == selemoji[6] || nihongo[int] == selemoji[7]  {
                int = Int.random(in: 0..<nihongo.count)
            }
            selemoji[5] = nihongo[int]
        }
        if damilen > 3 {
            while nihongo[int] == wordone || nihongo[int] == wordtwo || nihongo[int] == wordthree || nihongo[int] == wordfour || nihongo[int] == wordfive || nihongo[int] == wordfive || nihongo[int] == selemoji[5] || nihongo[int] == selemoji[6] || nihongo[int] == selemoji[7] {
                int = Int.random(in: 0..<nihongo.count)
            }
            selemoji[4] = nihongo[int]
        }
        if damilen > 4 {
            while nihongo[int] == wordone || nihongo[int] == wordtwo || nihongo[int] == wordthree || nihongo[int] == wordfour || nihongo[int] == wordfive || nihongo[int] == wordfive || nihongo[int] == selemoji[4] || nihongo[int] == selemoji[5] || nihongo[int] == selemoji[6] || nihongo[int] == selemoji[7] {
                int = Int.random(in: 0..<nihongo.count)
            }
            selemoji[3] = nihongo[int]
        }
        
        let ran = Int.random(in: 0..<8)
        
        switch ran {
        case 0:
            image = UIImage(named: "パネル" + selemoji[5] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[1] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[6] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel7.image = image
            chose = ["",selemoji[5],selemoji[7],selemoji[4],selemoji[1],selemoji[3],selemoji[6],selemoji[2]]
        case 1:
            image = UIImage(named: "パネル" + selemoji[3] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[1] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[6] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel7.image = image
            chose = ["",selemoji[3],selemoji[7],selemoji[1],selemoji[5],selemoji[4],selemoji[6],selemoji[2]]
            
        case 2:
            image = UIImage(named: "パネル" + selemoji[6] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[1] )
            sel7.image = image
            chose = ["",selemoji[6],selemoji[7],selemoji[2],selemoji[5],selemoji[4],selemoji[3],selemoji[1]]
        case 3:
            image = UIImage(named: "パネル" + selemoji[6] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[1] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel7.image = image
            chose = ["",selemoji[6],selemoji[5],selemoji[4],selemoji[1],selemoji[3],selemoji[7],selemoji[2]]
        case 4:
            image = UIImage(named: "パネル" + selemoji[1] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[6] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel7.image = image
            chose = ["",selemoji[1],selemoji[3],selemoji[4],selemoji[6],selemoji[2],selemoji[5],selemoji[7]]
            
        case 5:
            image = UIImage(named: "パネル" + selemoji[4] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[1] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[6] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel7.image = image
            chose = ["",selemoji[4],selemoji[1],selemoji[3],selemoji[5],selemoji[2],selemoji[6],selemoji[7]]
        case 6:
            image = UIImage(named: "パネル" + selemoji[6] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[1] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel7.image = image
            chose = ["",selemoji[6],selemoji[2],selemoji[7],selemoji[3],selemoji[1],selemoji[4],selemoji[5]]
        case 7:
            image = UIImage(named: "パネル" + selemoji[1] )
            sel1.image = image
            image = UIImage(named: "パネル" + selemoji[3] )
            sel2.image = image
            image = UIImage(named: "パネル" + selemoji[5] )
            sel3.image = image
            image = UIImage(named: "パネル" + selemoji[7] )
            sel4.image = image
            image = UIImage(named: "パネル" + selemoji[2] )
            sel5.image = image
            image = UIImage(named: "パネル" + selemoji[4] )
            sel6.image = image
            image = UIImage(named: "パネル" + selemoji[6] )
            sel7.image = image
            chose = ["",selemoji[1],selemoji[3],selemoji[5],selemoji[7],selemoji[2],selemoji[4],selemoji[6]]
        default:
            print("error")
        }
    }
    
    var movenum = 0
    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        let touchEvent = touches.first!        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        if preDx > 54 && preDx < 150 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 1 //セレクト1つ目
        }
        
        if preDx > 168 && preDx < 264 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 2 //セレクト2つ目
        }
        
        if preDx > 283 && preDx < 379 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 3 //セレクト3つ目
        }
        if preDx > 393 && preDx < 489 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 4 //セレクト4つ目
        }
        if preDx > 515 && preDx < 611 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 5 //セレクト5つ目
        }
        if preDx > 633 && preDx < 729 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 6  //セレクト6つ目
        }
        if preDx > 744 && preDx < 840 && preDy > 464 && preDy < 582{
            print("OK")
            movenum = 7 //セレクト7つ目
        }
        
    }
    






    
    
//ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {


        switch movenum {
        case 1:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel1.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel1.frame = viewFrame
            

            
            self.view.addSubview(sel1)
            
        case 2:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel2.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel2.frame = viewFrame
            
        case 3:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel3.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel3.frame = viewFrame
            
            
            
            self.view.addSubview(sel3)
            
        case 4:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel4.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel4.frame = viewFrame
            
            
            
            self.view.addSubview(sel4)
            
            
        case 5:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel5.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel5.frame = viewFrame
            
            
            
            self.view.addSubview(sel5)
            
            
        case 6:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel6.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel6.frame = viewFrame
            
            
            
            self.view.addSubview(sel6)
            
            
        case 7:
            // タッチイベントを取得
            let touchEvent = touches.first!
            
            // ドラッグ前の座標, Swift 1.2 から
            let preDx = touchEvent.previousLocation(in: self.view).x
            let preDy = touchEvent.previousLocation(in: self.view).y
            // ドラッグ後の座標
            let newDx = touchEvent.location(in: self.view).x
            let newDy = touchEvent.location(in: self.view).y
            
            // ドラッグしたx座標の移動距離
            let dx = newDx - preDx
            print("x:\(dx)")
            
            // ドラッグしたy座標の移動距離
            let dy = newDy - preDy
            print("y:\(dy)")
            
            // 画像のフレーム
            var viewFrame: CGRect = sel7.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            sel7.frame = viewFrame
            
            
            
            self.view.addSubview(sel7)
            
        default:
            print("baddd")
        }


    }
    
// ドラッグ終了
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touchEvent = touches.first!

        let placex = touchEvent.location(in: self.view).x
        let placey = touchEvent.location(in: self.view).y

        switch movenum {
        case 1:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[1] == wordone {
                    sel1.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel1.frame.origin.x = 54
                    sel1.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[1] == wordtwo {
                    sel1.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel1.frame.origin.x = 54
                    sel1.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[1] == wordthree {
                    sel1.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel1.frame.origin.x = 54
                    sel1.frame.origin.y = 464
                }
            }
            
                
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[1] == wordfour {
                    sel1.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel1.frame.origin.x = 54
                    sel1.frame.origin.y = 464
                }
                
            }
                
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[1] == wordfive {
                    sel1.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel1.frame.origin.x = 54
                    sel1.frame.origin.y = 464
                }
                
            }
            else {
                sel1.frame.origin.x = 54
                sel1.frame.origin.y = 464
                
            }
            
            
            
            
            

        case 2:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[2] == wordone {
                    sel2.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel2.frame.origin.x = 168
                    sel2.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[2] == wordtwo {
                    sel2.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel2.frame.origin.x = 168
                    sel2.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[2] == wordthree {
                    sel2.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel2.frame.origin.x = 168
                    sel2.frame.origin.y = 464
                }
            }
            
            
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[2] == wordfour {
                    sel2.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel2.frame.origin.x = 168
                    sel2.frame.origin.y = 464
                }
                
            }
            
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[2] == wordfive {
                    sel2.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel2.frame.origin.x = 168
                    sel2.frame.origin.y = 464
                }
                
            }
            else {
                sel2.frame.origin.x = 168
                sel2.frame.origin.y = 464
                
            }
        
            
            
            
        case 3:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[3] == wordone {
                    sel3.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel3.frame.origin.x = 283
                    sel3.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[3] == wordtwo {
                    sel3.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel3.frame.origin.x = 283
                    sel3.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[3] == wordthree {
                    sel3.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel3.frame.origin.x = 283
                    sel3.frame.origin.y = 464
                }
            }
            
            
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[3] == wordfour {
                    sel3.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel3.frame.origin.x = 283
                    sel3.frame.origin.y = 464
                }
                
            }
            
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[3] == wordfive {
                    sel3.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel3.frame.origin.x = 283
                    sel3.frame.origin.y = 464
                }
                
            }
            else {
                sel3.frame.origin.x = 283
                sel3.frame.origin.y = 464
                
            }
            
            
            
        case 4:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[4] == wordone {
                    sel4.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel4.frame.origin.x = 393
                    sel4.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[4] == wordtwo {
                    sel4.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel4.frame.origin.x = 393
                    sel4.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[4] == wordthree {
                    sel4.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel4.frame.origin.x = 393
                    sel4.frame.origin.y = 464
                }
            }
            
            
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[4] == wordfour {
                    sel4.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel4.frame.origin.x = 393
                    sel4.frame.origin.y = 464
                }
                
            }
            
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[4] == wordfive {
                    sel4.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel4.frame.origin.x = 393
                    sel4.frame.origin.y = 464
                }
                
            }
            else {
                sel4.frame.origin.x = 393
                sel4.frame.origin.y = 464
                
            }
            
        case 5:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[5] == wordone {
                    sel5.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel5.frame.origin.x = 515
                    sel5.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[5] == wordtwo {
                    sel5.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }
                    else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel5.frame.origin.x = 515
                    sel5.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[5] == wordthree {
                    sel5.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }
                    else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel5.frame.origin.x = 515
                    sel5.frame.origin.y = 464
                }
            }
            
            
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[5] == wordfour {
                    sel5.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel5.frame.origin.x = 515
                    sel5.frame.origin.y = 464
                }
                
            }
            
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[5] == wordfive {
                    sel5.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel5.frame.origin.x = 515
                    sel5.frame.origin.y = 464
                }
                
            }
            else {
                sel5.frame.origin.x = 515
                sel5.frame.origin.y = 464
                
            }
            
        case 6:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[6] == wordone {
                    sel6.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }
                    else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel6.frame.origin.x = 633
                    sel6.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[6] == wordtwo {
                    sel6.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }
                    else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel6.frame.origin.x = 633
                    sel6.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[6] == wordthree {
                    sel6.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }
                    else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel6.frame.origin.x = 633
                    sel6.frame.origin.y = 464
                }
            }
            
            
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[6] == wordfour {
                    sel6.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel6.frame.origin.x = 633
                    sel6.frame.origin.y = 464
                }
                
            }
            
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[6] == wordfive {
                    sel6.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }
                    else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel6.frame.origin.x = 633
                    sel6.frame.origin.y = 464
                }
                
            }
            else {
                sel6.frame.origin.x = 633
                sel6.frame.origin.y = 464
            }
            
        case 7:
            if placex > 64 && placex < 202 && placey > 55 && placey < 237{
                if chose[7] == wordone {
                    sel7.image = nil
                    let image = UIImage(named: "Yパネル" + wordone )
                    one.image = image
                    wordNokori = wordNokori - 1
                    print("putOK1")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel7.frame.origin.x = 744
                    sel7.frame.origin.y = 464
                }
            }
            if placex > 253 && placex < 391 && placey > 55 && placey < 237{
                if chose[7] == wordtwo {
                    sel7.image = nil
                    let image = UIImage(named: "Yパネル" + wordtwo )
                    two.image = image
                    wordNokori = wordNokori - 1
                    print("putOK2")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    let sound = NSDataAsset(name: "machigaiSound")
                    player = try? AVAudioPlayer(data: sound!.data)
                    player?.play()
                    sel7.frame.origin.x = 744
                    sel7.frame.origin.y = 464
                }
            }
            
            if placex > 455 && placex < 593 && placey > 55 && placey < 237{
                if chose[3] == wordthree {
                    sel7.image = nil
                    let image = UIImage(named: "Yパネル" + wordthree )
                    three.image = image
                    wordNokori = wordNokori - 1
                    print("putOK3")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 2{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel7.frame.origin.x = 744
                    sel7.frame.origin.y = 464
                }
            }
            
            
            if placex > 648 && placex < 786 && placey > 55 && placey < 237{
                if chose[3] == wordfour {
                    sel7.image = nil
                    let image = UIImage(named: "Yパネル" + wordfour )
                    four.image = image
                    wordNokori = wordNokori - 1
                    print("putOK4")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 3{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel7.frame.origin.x = 744
                    sel7.frame.origin.y = 464
                }
                
            }
            
            
            if placex > 822 && placex < 960 && placey > 55 && placey < 237{
                if chose[7] == wordfive {
                    sel7.image = nil
                    let image = UIImage(named: "Yパネル" + wordfive )
                    five.image = image
                    wordNokori = wordNokori - 1
                    print("putOK5")
                    if wordNokori == 0{
                        seikai()
                    }else{
                        let sound = NSDataAsset(name: "mojiIn")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                }else {
                    if wordlen > 4{
                        let sound = NSDataAsset(name: "machigaiSound")
                        player = try? AVAudioPlayer(data: sound!.data)
                        player?.play()
                    }
                    sel7.frame.origin.x = 744
                    sel7.frame.origin.y = 464
                }
                
            }
            else {
                sel7.frame.origin.x = 744
                sel7.frame.origin.y = 464
                
            }
            
            
        default:
            print("notmove")
        }
        
        movenum = 0
    }
    
    
    func seikai() {
        self.view.bringSubviewToFront(irasuto)
        self.view.bringSubviewToFront(maru)
        maru.isHidden = false
        let imageirasuto = UIImage(named: word )
        irasuto.image = imageirasuto
        irasuto.backgroundColor = UIColor.white
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.seikaiCount = appDelegate.seikaiCount + 1
        let sound = NSDataAsset(name: "seikaiSound")
        player = try? AVAudioPlayer(data: sound!.data)
        player?.play()
        seikaimati = 2
        
    }
    
    

    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //1つ前にもどる
    }
    @IBAction func skip(_ sender: Any) {
        loadView()
        viewDidLoad()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func updateTimer() {
        if seikaimati == 0{
            if count > 0{
                count = count - 1
                nokori.setProgress(nokori.progress - 0.0167, animated: true)
                
                //timerCountLabelのtextプロパティへString型にキャストしたcount変数を代入する（表示させる）
                timerCountLabel.text = String(count)
                progress = nokori.progress
                if count <= 10{
                    nokori.progressTintColor = UIColor.red
                    timerCountLabel.textColor = UIColor.red
                }
            }else{
                self.performSegue(withIdentifier: "toResult1", sender: self)
            }
        }else{
            if seikaimati == 1{
                seikaimati = 0
                loadView()
                viewDidLoad()
            }else{
                seikaimati = 1
            }

        }
    }
    
}
