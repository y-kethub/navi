//
//  StudyJapanese2ViewController.swift
//  navi
//
//  Created by student on 2019/10/30.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class StudyJapanese2ViewController: UIViewController {

    @IBOutlet weak var One: UIImageView!
    @IBOutlet weak var Two: UIImageView!
    @IBOutlet weak var Three: UIImageView!
    @IBOutlet weak var Four: UIImageView!
    @IBOutlet weak var Five: UIImageView!
    @IBOutlet weak var bigMihon: UIImageView!
    
    
    
    
    var wordone = "Q"
    var wordtwo = "Q"
    var wordthree = "Q"
    var wordfour = "Q"
    var wordfive = "Q"
    var wordNokori = 0
    var nowpoint = 0
    
    var bezier : UIBezierPath!
    var Image :UIImage!
    @IBOutlet var canvas: UIImageView!
    @IBOutlet weak var hintSwitchOut: UISwitch!
    @IBOutlet weak var Guide: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chooseWord()
        
        bigMihon.image = UIImage(named: "パネル" + wordone )
        nowpoint = 1
        
        //canvas設定
        canvas = UIImageView()
        canvas.frame = CGRect(x:578, y:279, width:382, height:382)
        canvas.backgroundColor = UIColor.clear
        self.view.addSubview(canvas)
        // Do any additional setup after loading the view.
        
        Guide.image = UIImage(named: "25パネル" + wordone )
    }
    func chooseWord() {
        var selemoji: [String] = ["","","","","","","",""]
        let siriwords:[String] = ["AAIISU","IISU","UUSAGI","EENOGU","OONIGIRI","KAEERU","KITUNE","KURUMA","KEIISATU","KOAARA","SARU","SISO","SUSI","SEMI","SOBA","TAKO","TI00ZU","TUKI","TEREBI","TOIIRE","NASU","NIKU","NUIIGURUMI","NEKO","NORI","HABURASI","HIMO","HUUUSENN","HEBI","HOTARU","MAKURA","MIZU","MUSIKAGO","MEDAKA","MORI","YAGI","YUKI","YOLLTO","RANNDOSERU","RINNGO","RU00RELLTO","REIIZOUUKO","ROUUSOKU","WANI"]
        
        let random:Int = Int(arc4random_uniform(43))
        
        let word:String = siriwords[random]
        print(word)
        
        
        
        let wordlen = word.count / 2
        wordNokori = wordlen
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.mojisu = wordlen
        appDelegate.selemoji = word
        
        print(wordlen)
        
        wordone = String(word[word.index(word.startIndex, offsetBy: 0)..<word.index(word.startIndex, offsetBy: 2)])
        var image = UIImage(named: "パネル" + wordone )
        One.image = image
        selemoji[1] = wordone
        
        if Int(wordlen) > 1 {
            wordtwo = String(word[word.index(word.startIndex, offsetBy: 2)..<word.index(word.startIndex, offsetBy: 4)])
            image = UIImage(named: "パネル" + wordtwo )
            Two.image = image
            selemoji[2] = wordtwo
        }
        
        if wordlen > 2 {
            wordthree = String(word[word.index(word.startIndex, offsetBy: 4)..<word.index(word.startIndex, offsetBy: 6)])
            image = UIImage(named: "パネル" + wordthree )
            Three.image = image
            selemoji[3] = wordthree
        }
        
        if wordlen > 3 {
            wordfour = String(word[word.index(word.startIndex, offsetBy: 6)..<word.index(word.startIndex, offsetBy: 8)])
            image = UIImage(named: "パネル" + wordfour )
            Four.image = image
            selemoji[4] = wordfour
        }
        
        if wordlen > 4 {
            wordfive = String(word[word.index(word.startIndex, offsetBy: 8)..<word.index(word.startIndex, offsetBy: 10)])
            image = UIImage(named: "パネル" + wordfive )
            Five.image = image
            selemoji[5] = wordfive
        }
    }
    //タッチイベント
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   //タッチ時のイベントを習得
        let touchEvent = touches.first!
        //タッチしている座標を習得
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        bezier = UIBezierPath()
        //ペンの太さ
        bezier.lineWidth = 10.0
        //ペンのスタイル
        bezier.lineCapStyle = .round
        //支点に現在タッチしている位置をセット
        bezier.move(to:currentPoint)
        
    }
    
    //ドラックイベント
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチ開始時bizierを初期化していない場合処理終了
        if bezier == nil {
            return
        }
        //タッチ時のイベント習得
        let touchEvent = touches.first!
        //タッチしている座標取得
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        //ベジェ曲線を描く
        bezier.addLine(to: currentPoint)
        //描写メソッド（後述）
        drawLine(path: bezier)
    }
    
    //指を離した時のイベント
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if bezier == nil {
                return
            }
            let touchEvent = touches.first!
            let currentPoint:CGPoint = touchEvent.location(in: canvas)
            bezier.addLine(to: currentPoint)
            drawLine(path: bezier)
        //Imageにcanvasのimageを保存
            self.Image = canvas.image
    }
    
    //描画処理
    func drawLine(path:UIBezierPath){
        UIGraphicsBeginImageContext(canvas.frame.size)
        if let image = self.Image {
            image.draw(at: CGPoint.zero)
        }
        //線のカラー
        let lineColor = UIColor.black
        //線のスタイル
        lineColor.setStroke()
        path.stroke()
        //canvasに画像を表示
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    //消す
    func clear(){
        Image = nil
        canvas.image = nil
    }
    //つぎへ
    @IBAction func Next(_ sender: Any) {
        if canvas.image !== nil {
            
            let appDelegate:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            appDelegate.writeString.append(canvas.image!)
            clear()
            wordNokori = wordNokori - 1
            
            if wordNokori == 0{
                print("owari")
                self.performSegue(withIdentifier: "toResult2", sender: self)
            }else{
                switch nowpoint {
                case 1:
                    bigMihon.image = UIImage(named: "パネル" + wordtwo )
                    nowpoint = 2
                case 2:
                    bigMihon.image = UIImage(named: "パネル" + wordthree )
                    nowpoint = 3
                case 3:
                    bigMihon.image = UIImage(named: "パネル" + wordfour )
                    nowpoint = 4
                case 4:
                    bigMihon.image = UIImage(named: "パネル" + wordfive )
                    nowpoint = 5
                    
                default:
                    print("error")
                }
            }
                
            if hintSwitchOut.isOn {
                switch nowpoint {
                case 1:
                    Guide.image = UIImage(named: "25パネル" + wordone )
                case 2:
                    Guide.image = UIImage(named: "25パネル" + wordtwo )
                case 3:
                    Guide.image = UIImage(named: "25パネル" + wordthree )
                case 4:
                    Guide.image = UIImage(named: "25パネル" + wordfour )
                case 5:
                    Guide.image = UIImage(named: "25パネル" + wordfive )
                    
                default:
                    print("error")
                }
                    
            } else {
                Guide.image = nil
            }
                
        } else {
            let alert: UIAlertController = UIAlertController(title: "ちゅうい", message: "なにもかかれていないので\nつぎにすすめません", preferredStyle:  UIAlertController.Style.alert)
                
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(defaultAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    //なぞりガイド
    @IBAction func hintSwitch(_ sender: Any) {
        if (sender as AnyObject).isOn {
            switch nowpoint {
            case 1:
                Guide.image = UIImage(named: "25パネル" + wordone )
            case 2:
                Guide.image = UIImage(named: "25パネル" + wordtwo )
            case 3:
                Guide.image = UIImage(named: "25パネル" + wordthree )
            case 4:
                Guide.image = UIImage(named: "25パネル" + wordfour )
            case 5:
                Guide.image = UIImage(named: "25パネル" + wordfive )
                
            default:
                print("error")
            }

        } else {
            Guide.image = nil
        }
    }
    
    func save(){
        UIImageWriteToSavedPhotosAlbum(Image, self, nil, nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func clearButton(_ sender: Any) {
        clear()
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //1つ前にもどる
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
