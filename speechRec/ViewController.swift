//
//  ViewController.swift
//  speechRec
//
//  Created by Fnu, Rohit on 9/4/16.
//  Copyright © 2016 Fnu, Rohit. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
   // var audioEngine = AVAudioEngine()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        player.stop()
        activitySpinner.startAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth()
    {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "mpthreetest", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    }   catch {
                        print("error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url:path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                        print("there is a error\(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func playButtonPress(_ sender: AnyObject)
    {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
}

