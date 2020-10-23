//
//  VideoPlayerViewController.swift
//  StreamingVideo
//
//  Created by JunghunSeo on 2020/09/26.
//  Copyright © 2020 JunghunSeo. All rights reserved.
//

import UIKit

final class VideoPlayerViewController: UIViewController {
    
    var url: URL?
    
    @IBOutlet weak var videoView: VideoPlayerView!
    @IBOutlet weak var hudView: UIView!
    @IBOutlet weak var playImage: UIImageView!
    
    var hudTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        
        if let url = url {
            play(url)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        videoView.playerLayer?.frame = rect
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension VideoPlayerViewController {
    
    private func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playToEnd),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
    
    private func play(_ url: URL?) {
        guard let url = url else { return }
        playImage.image = UIImage(systemName: "pause.fill")
        videoView.play(url: url)
        
        startHudTimer()
    }
    
    private func play() {
        playImage.image = UIImage(systemName: "pause.fill")
        videoView.play()
    }
    
    private func pause() {
        playImage.image = UIImage(systemName: "play.fill")
        videoView.pause()
    }
    
    private func startHudTimer() {
        stopHudTimer()
        
        hudTimer = Timer.scheduledTimer(
            timeInterval: 3.0,
            target: self,
            selector: #selector(hideHudView),
            userInfo: nil,
            repeats: false
        )
    }
    
    private func stopHudTimer() {
        hudTimer?.invalidate()
        hudTimer = nil
    }
    
    private func showHudView() {
        UIView.animate(withDuration: 1.0) {
            self.hudView.isHidden = false
        }
        startHudTimer()
    }
    
    @objc
    private func hideHudView() {
        UIView.animate(withDuration: 1.0) {
            self.hudView.isHidden = true
        }
        stopHudTimer()
    }
    
    @objc
    private func playToEnd() {
        playImage.image = UIImage(systemName: "repeat")
        videoView?.end()
        showHudView()
        stopHudTimer()
    }
}

extension VideoPlayerViewController {
    
    @IBAction func hudTapGesture(_ sender: Any) {
        guard
            let state = videoView?.state,
            state != .end
        else { return }
        
        hideHudView()
    }
    
    @IBAction func videoViewTapGesture(_ sender: Any) {
        showHudView()
    }
        
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        guard
            let state = videoView?.state,
            let url = url
        else { return }
        
        switch state {
        case .play:
            pause()
        case .pause:
            play()
        case .end:
            play(url)
        }
        startHudTimer()
    }
}
