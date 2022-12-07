//
//  Result2ViewController.swift
//  navi
//
//  Created by student on 2019/11/27.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Accounts
import Photos

class Result2ViewController: UIViewController {

    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var four: UIImageView!
    @IBOutlet weak var five: UIImageView!
    @IBOutlet weak var irasuto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate 
        one.image = appDelegate.writeString[0]
        two.image = appDelegate.writeString[1]
        if appDelegate.mojisu > 2 {
            three.image = appDelegate.writeString[2]
            three.backgroundColor = UIColor.white
        }
        if appDelegate.mojisu > 3 {
            four.image = appDelegate.writeString[3]
            four.backgroundColor = UIColor.white

        }
        if appDelegate.mojisu > 4 {
            five.image = appDelegate.writeString[4]
            five.backgroundColor = UIColor.white

        }
        appDelegate.writeString.removeAll()
        let gazouyoumozi = appDelegate.selemoji
        let imageirasuto = UIImage(named: gazouyoumozi )
        irasuto.image = imageirasuto
    }
    

    
    @IBAction func savePic(_ sender: Any) {

        
        let alertController = UIAlertController(title: "ほぞん", message: "しゃしんアプリにほぞんしますか？", preferredStyle: .alert)
        //OK
        let okAction = UIAlertAction(title: "はい", style: .default) { (ok) in
            
            
            
            // croppingをカメラロールに保存
            UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0.0)
            //viewを書き出す
            self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
            // imageにコンテキストの内容を書き出す
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            //コンテキストを閉じる
            UIGraphicsEndImageContext()
            
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
            
            // 文字のところだけ切り取り
            let cropping = image.cropping(to: CGRect(x: 82, y: 70, width: 138 * appDelegate.mojisu, height: 182 ))
            
            UIImageWriteToSavedPhotosAlbum(cropping!, self, #selector(self.didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)), nil)
            
            
        }
        //CANCEL
        let cancelAction = UIAlertAction(title: "いいえ", style: .default) { (cancel) in
            alertController.dismiss(animated: true, completion: nil)
        }
        //OKとCANCELを表示追加し、アラートを表示
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        

    }
    
    
    // 保存を試みた結果を受け取る
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        // 結果によって出すアラートを変更する
        var title = "ほぞんかんりょう"
        var message = "しゃしんアプリにほぞんしました"
        if error != nil {
            title = "ほぞんしっぱい"
            message = "せっていアプリからナビトレをえらび、\nしゃしんをえらび、\nしゃしんのみついかをきょかをタップしてください。\nそのあともういちどためしてください。"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    

    
    
    @IBAction func print(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0.0)        //viewを書き出す
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        // imageにコンテキストの内容を書き出す
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //コンテキストを閉じる
        UIGraphicsEndImageContext()
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 文字のところだけ切り取り
        let cropping = image.cropping(to: CGRect(x: 82, y: 70, width: 138 * appDelegate.mojisu, height: 182 ))
        
        
        let shareImage = cropping as Any
        let shareItems = [shareImage]
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = self.shareButton
            present(controller, animated: true, completion: nil)
        
        
    
    }
    @IBOutlet weak var shareButton: UIButton!
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func backButton(_ sender: Any) {
        //2つ前に戻る
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    
}

extension UIImage {
    func cropping(to: CGRect) -> UIImage? {
        var opaque = false
        if let cgImage = cgImage {
            switch cgImage.alphaInfo {
            case .noneSkipLast, .noneSkipFirst:
                opaque = true
            default:
                break
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(to.size, opaque, scale)
        draw(at: CGPoint(x: -to.origin.x, y: -to.origin.y))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}



