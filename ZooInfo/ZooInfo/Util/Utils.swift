//
//  Utils.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/21.
//

import Foundation
import AVFAudio

class Utils {
    
    private static let synthesizer = AVSpeechSynthesizer()
    
    static func speechText(text:String, language: String = "zh-TW") {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        
        
        synthesizer.speak(utterance)
    }
}
