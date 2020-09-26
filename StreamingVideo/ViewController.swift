//
//  ViewController.swift
//  StreamingVideo
//
//  Created by JunghunSeo on 2020/09/26.
//  Copyright © 2020 JunghunSeo. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!

    @IBAction func playButtonPressed(_ sender: Any) {
        guard
            let videoUrlString = urlTextField.text,
            let videoUrl = URL(string: videoUrlString)
        else { return }
        
        let playerViewController = AVPlayerViewController()
        let player = AVPlayer(url: videoUrl)
        playerViewController.player = player

        present(playerViewController, animated: true) {
          player.play()
        }
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

