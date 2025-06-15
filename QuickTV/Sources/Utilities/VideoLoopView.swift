//
//  VideoLoopView.swift
//  QuickTV
//
//  Created by Pradeep KN on 16/06/25.
//

import SwiftUI
import AVKit

struct VideoLoopView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    @Binding var isMute: Bool

    private let player: AVQueuePlayer
    private let looper: AVPlayerLooper

    init(videoName: String, fileExtension: String = "mp4", isPlaying: Binding<Bool>, isMute: Binding<Bool>) {
        self._isPlaying = isPlaying
        self._isMute = isMute
        guard let url = Bundle.main.url(forResource: videoName, withExtension: fileExtension) else {
            fatalError("❌ Couldn't find video: \(videoName).\(fileExtension)")
        }

        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        self.player = AVQueuePlayer()
        self.looper = AVPlayerLooper(player: player, templateItem: item)
        self.player.volume = 0.1
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.cornerRadius = 20
        playerLayer.masksToBounds = true

        view.layer.addSublayer(playerLayer)

        DispatchQueue.main.async {
            playerLayer.frame = view.bounds
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if isPlaying {
            player.play()
        } else {
            player.pause()
        }
        player.isMuted = isMute
    }
}
