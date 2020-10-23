//
//  VideoPlayerView.swift
//  StreamingVideo
//
//  Created by JunghunSeo on 2020/09/26.
//  Copyright © 2020 JunghunSeo. All rights reserved.
//

import UIKit
import AVFoundation

final class VideoPlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    var state: PlayerState = .play
    
    var playerLayer: AVPlayerLayer? {
        layer as? AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            playerLayer?.player
        }
        set {
            playerLayer?.player = newValue
        }
    }
    
    func play(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        
        self.player = player
        playerLayer?.frame = self.bounds
        playerLayer?.videoGravity = .resizeAspect
        
        self.isHidden = false
        
        play()
    }
    
    func play() {
        state = .play
        player?.play()
    }
    
    func pause() {
        state = .pause
        player?.pause()
    }
    
    func end() {
        state = .end
    }
}

enum PlayerState {
    case play
    case pause
    case end
}
