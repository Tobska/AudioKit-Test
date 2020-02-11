//
//  ViewController.swift
//  AudioKit-Test
//
//  Created by Patrick Tobias on 2/11/20.
//  Copyright © 2020 Patrick Tobias. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    var currBeat = 0
    var timer: Timer!
    
    // used for optimized
    var currBeatCounter = 0
    var currNote: Note!
    var currNoteIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // init AudioEngine
        let audioEngine = AudioEngine()
        
        // Array of notes for Ode to Joy
        let notes = [
            Note(type:.quarter,pitch:.E),
            Note(type:.quarter,pitch:.E),
            Note(type:.quarter,pitch:.F),
            Note(type:.quarter,pitch:.G),
            Note(type:.quarter,pitch:.G),
            Note(type:.quarter,pitch:.F),
            Note(type:.quarter,pitch:.E),
            Note(type:.quarter,pitch:.D),
            Note(type:.quarter,pitch:.C),
            Note(type:.quarter,pitch:.C),
            Note(type:.quarter,pitch:.D),
            Note(type:.quarter,pitch:.E),
            Note(type:.half,pitch:.E),
            Note(type:.quarter,pitch:.D),
            Note(type:.quarter,pitch:.D)
        ]
        
        //let processedNotes = processNotesForPlayback(notes: notes)
        
        // defined tempo
        let tempo = 120.0
        
        // 0.0078125 was derived from a quarter note having 1/128 beats
        /*self.timer = Timer.scheduledTimer(withTimeInterval: 60 / tempo * 0.0078125, repeats: true, block: {_ in self.playbackLoop(processedNotes: processedNotes, sampler: audioEngine.sampler)})*/
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 60 / tempo * 0.0078125, repeats: true, block: {_ in self.optimizedPlaybackLoop(notes: notes, sampler: audioEngine.sampler)})
    }
    
    func playbackLoop (processedNotes: [[Int?]], sampler: AKAppleSampler) {
        //print(self.currBeat)
        if let noteNumber = processedNotes[self.currBeat][0] {
            print("Current MIDI Note Played: \(noteNumber)")
            
            try! sampler.play(noteNumber: MIDINoteNumber(noteNumber))
        }
        
        self.currBeat += 1
        if (currBeat >= processedNotes.count) {
            self.timer.invalidate()
        }
    }
    
    func processNotesForPlayback (notes: [Note]) -> [[Int?]] {
        var playbackArray = [[Int?]]()
        
        for note in notes {
            for beat in 0..<note.value {
                if beat >= 1 {
                    // leave a trail of nil or null based on value/duration of note
                    // so that it doesn't play the next note while a current note is playing
                    playbackArray.append([nil])
                } else {
                    playbackArray.append([note.convertToMIDI()])
                }
            }
        }
        
        return playbackArray
    }
    
    func optimizedPlaybackLoop (notes: [Note], sampler: AKAppleSampler) {
        //print(self.currBeat)
        
        if self.currBeatCounter == 0 {
            self.currNoteIndex += 1
            
            if self.currNoteIndex > notes.count-1 {
                self.timer.invalidate()
                return
            }
            
            self.currNote = notes[self.currNoteIndex]
            print("Current MIDI Note Played: \(currNote.convertToMIDI())")
            
            try! sampler.play(noteNumber: MIDINoteNumber(currNote.convertToMIDI()))
        }
        
        self.currBeatCounter += 1
        
        if (currBeatCounter == currNote.value) {
            self.currBeatCounter = 0
            //self.timer.invalidate()
        }
    }
}

