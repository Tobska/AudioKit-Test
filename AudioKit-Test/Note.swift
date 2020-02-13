//
//  Note.swift
//  AudioKit-Test
//
//  Created by Patrick Tobias on 2/11/20.
//  Copyright © 2020 Patrick Tobias. All rights reserved.
//

import Foundation

enum Pitch {
    case C
    case D
    case E
    case F
    case G
    case A
    case B
}

// extend this for more notes
enum NoteType {
    case whole
    case half
    case quarter
    case sixtyFourth
}

class Note {
    var type:NoteType!
    var value:Int!
    var pitch:Pitch!
    
    // view https://github.com/vincegnzls/Flow/blob/master/Flow/Utils/SoundManager.swift
    // for more note to value conversions
    // we created values for each note
    // 8 being the lowest, 512 being the highest
    // 8 - was decided because its the number that you can divide up to 3 times
    //     that would become 1 (useful when accomodating dotted notes)
    init (type: NoteType, pitch:Pitch) {
        switch type {
        case .whole:
            value = 512
        case .half:
            value = 256
        case .quarter: // this is 1 beat
            value = 128
        case .sixtyFourth:
            value = 8
        }
        
        self.pitch = pitch
    }
    
    // view https://github.com/vincegnzls/Flow/blob/master/Flow/Utils/SoundManager.swift
    // for more note to MIDI conversions
    // note that the function inside that git repo has a +3 in the return statement so
    // all values there would have a +3, we were too lazy to convert everything pa so
    // there's a +3 (sorry)
    // so if ever you use that, just add a 3 to every MIDI number conversion we put in the
    // switch statements
    func convertToMIDI() -> Int {
        // all values here are in 4th octave
        
        var MIDINum = 0
        
        switch self.pitch {
        case .C:
            MIDINum = 63
        case .D:
            MIDINum = 65
        case .E:
            MIDINum = 67
        case .F:
            MIDINum = 68
        case .G:
            MIDINum = 70
        case .A:
            MIDINum = 72
        case .B:
            MIDINum = 74
        default:
            MIDINum = 63
        }
        
        return MIDINum
    }
}
