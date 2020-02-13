//
//  AudioEngine.swift
//  AudioKit-Test
//
//  Created by Patrick Tobias on 2/11/20.
//  Copyright © 2020 Patrick Tobias. All rights reserved.
//

import Foundation
import AudioKit

class AudioEngine {
    
    var mixer: AKMixer!
    var file: AKAudioFile!
    var sampler: AKAppleSampler!
    //var sampler2: AKAppleSampler!
    
    init() {
        do {
            file = try AKAudioFile(readFileName: "Grand Piano.wav")
            
            sampler = AKAppleSampler()
            //sampler2 = AKAppleSampler()
            
            // load the audio file into sampler
            try sampler.loadAudioFile(file)
            
            // if you have different .wav files, you need to create a new
            // sampler for it
            // e.g. piano accompanied by violin
            // create sampler with violinFile
            // try sampler2.loadAudioFile(violinFile)
            
            // you need to use sampler2 (instead of sampler)
            // to play the violin if that's the case
        } catch {
            AKLog("File Not Found")
            return
        }
        
        // you can add more samplers/nodes to the mixer
        mixer = AKMixer(sampler/*, sampler2*/)
        AudioKit.output = mixer
        
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
    }
    
}
