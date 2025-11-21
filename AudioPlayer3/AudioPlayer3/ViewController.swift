//
//  ViewController.swift
//  AudioPlayer3
//
//  Created by Amire Abdikadyr on 20.11.2025.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        playNextTrack()
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        togglePlayPause()
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        playPreviousTrack()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        guard let player = audioPlayer else { return }
        player.currentTime = TimeInterval(sender.value)
    }
    
    var audioPlayer: AVAudioPlayer?
    var currentIndex: Int = 0
    
    struct Track {
        let title: String
        let artist: String
        let fileName: String
        let imageName: String
    }
    
    var tracks: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracks = [
            Track(title: "ALASH", artist: "Mursallin", fileName: "alash", imageName: "song1"),
            Track(title: "fiesta bby", artist: "RRUXI", fileName: "fiesta", imageName: "song2"),
            Track(title: "Nite", artist: "Elven Dior", fileName: "nite", imageName: "song3"),
            Track(title: "Pon De Replay", artist: "Ed Marquis, Emie", fileName: "pon_de_replay", imageName: "song4"),
            Track(title: "There's Nothing Holdin' Me Back", artist: "Shawn Mendes", fileName: "there_is_nothing_holding_me_back", imageName: "song5"),
            Track(title: "Timeless", artist: "Dan Korshunov", fileName: "timeless", imageName: "song6")
        ]
        
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        setupUI()
        loadTrack(at: currentIndex)
    }
    
    func setupUI() {
        albumImageView.layer.cornerRadius = 20
        albumImageView.clipsToBounds = true
        albumImageView.layer.shadowColor = UIColor.black.cgColor
        albumImageView.layer.shadowOpacity = 0.3
        albumImageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        albumImageView.layer.shadowRadius = 20
        albumImageView.layer.masksToBounds = false
        
        songTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        songTitleLabel.textColor = .label
        
        artistLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        artistLabel.textColor = .secondaryLabel
        
        progressSlider.minimumTrackTintColor = .systemBlue
        progressSlider.maximumTrackTintColor = .systemGray5
        progressSlider.setThumbImage(createCircleImage(size: 16, color: .systemBlue), for: .normal)
        progressSlider.setThumbImage(createCircleImage(size: 18, color: .systemBlue), for: .highlighted)
        
        styleButton(playPauseButton, size: 70, backgroundColor: .systemBlue)
        styleButton(previousButton, size: 50, backgroundColor: .systemGray6)
        styleButton(nextButton, size: 50, backgroundColor: .systemGray6)
        
        playPauseButton.tintColor = .white
        previousButton.tintColor = .systemBlue
        nextButton.tintColor = .systemBlue
        
        playPauseButton.layer.shadowColor = UIColor.systemBlue.cgColor
        playPauseButton.layer.shadowOpacity = 0.3
        playPauseButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        playPauseButton.layer.shadowRadius = 10
    }
    
    func styleButton(_ button: UIButton, size: CGFloat, backgroundColor: UIColor) {
        button.layer.cornerRadius = size / 2
        button.backgroundColor = backgroundColor
        button.layer.masksToBounds = true
        
        button.widthAnchor.constraint(equalToConstant: size).isActive = true
        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: size * 0.4, weight: .semibold)
        button.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
    }
    
    func createCircleImage(size: CGFloat, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        return renderer.image { context in
            color.setFill()
            context.cgContext.fillEllipse(in: CGRect(x: 0, y: 0, width: size, height: size))
        }
    }
    
    func loadTrack(at index: Int) {
        guard tracks.indices.contains(index) else { return }
        let track = tracks[index]
        
        UIView.transition(with: songTitleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.songTitleLabel.text = track.title
        }
        
        UIView.transition(with: artistLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.artistLabel.text = track.artist
        }
        
        
        UIView.transition(with: albumImageView, duration: 0.5, options: .transitionCrossDissolve) {
            self.albumImageView.image = UIImage(named: track.imageName)
        }
        
        if let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.prepareToPlay()
                if let player = audioPlayer {
                    progressSlider?.value = 0
                    progressSlider?.minimumValue = 0
                    progressSlider?.maximumValue = Float(player.duration)
                    startProgressTimer()
                }
            } catch {
                print("Error loading audio: \(error)")
            }
        } else {
            print("Audio file not found: \(track.fileName).mp3")
        }
        
        updatePlayPauseButton(isPlaying: false)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer?.invalidate()
        progressSlider?.value = 0
        playNextTrack()
    }

    
    func togglePlayPause() {
        guard let player = audioPlayer else { return }
        
        
        UIView.animate(withDuration: 0.1, animations: {
            self.playPauseButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.playPauseButton.transform = .identity
            }
        }
        
        if player.isPlaying {
            player.pause()
            updatePlayPauseButton(isPlaying: false)
        } else {
            player.play()
            updatePlayPauseButton(isPlaying: true)
        }
    }
    
    func updatePlayPauseButton(isPlaying: Bool) {
        let symbolName = isPlaying ? "pause.fill" : "play.fill"
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfig)
        
        UIView.transition(with: playPauseButton, duration: 0.2, options: .transitionCrossDissolve) {
            self.playPauseButton.setImage(image, for: .normal)
        }
    }
    
    func playNextTrack() {
        animateButton(nextButton)
        currentIndex += 1
        if currentIndex >= tracks.count {
            currentIndex = 0
        }
        loadTrack(at: currentIndex)
        audioPlayer?.play()
        updatePlayPauseButton(isPlaying: true)
    }
    
    func playPreviousTrack() {
        animateButton(previousButton)
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = tracks.count - 1
        }
        loadTrack(at: currentIndex)
        audioPlayer?.play()
        updatePlayPauseButton(isPlaying: true)
    }
    
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = .identity
            }
        }
    }
    
    var progressTimer: Timer?
    
    func startProgressTimer() {
        progressTimer?.invalidate()
        guard audioPlayer != nil else { return }
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.updateProgressSlider()
        }
    }
    
    func updateProgressSlider() {
        guard let player = audioPlayer, player.duration > 0 else { return }
        progressSlider?.value = Float(player.currentTime)
    }
}
