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

enum NoteType {
    case whole
    case half
    case quarter
}

class Note {
    var type:NoteType!
    var value:Int!
    var pitch:Pitch!
    
    init (type: NoteType, pitch:Pitch) {
        switch type {
        case .whole:
            value = 512
        case .half:
            value = 256
        case .quarter:
            value = 128
        }
        
        self.pitch = pitch
    }
    
    func convertToMIDI() -> Int {
        // all values here are in 4th octave
        
        var MIDINum = 0
        
        switch self.pitch {
        case .C:
            MIDINum = 60
        case .D:
            MIDINum = 62
        case .E:
            MIDINum = 64
        case .F:
            MIDINum = 65
        case .G:
            MIDINum = 67
        case .A:
            MIDINum = 69
        case .B:
            MIDINum = 71
        default:
            MIDINum = 60
        }
        
        return MIDINum
    }
}
