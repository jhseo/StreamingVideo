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
    @IBOutlet weak var videoView: VideoPlayerView!

    let videoURLString =
    "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4"
    let hlsVideUrlString = "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8"
    
    private var playerLayer: AVPlayerLayer?
}

extension ViewController {
    
    @IBAction func playButtonPressed(_ sender: Any) {
        view.endEditing(true)
        guard
            let videoUrlString = urlTextField.text,
            let url = URL(string: videoUrlString)
        else { return }
            
        openVideoPlayerView(url: url)
    }
    
    @IBAction func playSampleButtonPressed(_ sender: Any) {
        view.endEditing(true)
        guard
            let url = URL(string: hlsVideUrlString)
        else { return }
            
        openVideoPlayerView(url: url)
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
}

extension ViewController {
    
    private func openVideoPlayerView(url: URL) {
        let storyboard = UIStoryboard(name: "VideoPlayerViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController else { return }
        vc.url = url
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

