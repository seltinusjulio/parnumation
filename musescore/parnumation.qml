//=============================================================================
//  MuseScore
//  Music Composition & Notation
//
//  Note Numbers Plugin (derived from the Note Names Plugin)
//
//  Copyright (C) 2012 Werner Schweer
//  Copyright (C) 2013 - 2024 Joachim Schmitz
//  Copyright (C) 2014 Jörn Eichler
//  Copyright (C) 2020 Johan Temmerman
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
//=============================================================================

import QtQuick 2.2
import MuseScore 3.0

MuseScore {
   version: "4.4"
   description: "This plugin numbers notes"
   menuPath: "Plugins.Notes." + "Note Numbers" [cite: 311]

   // Small note name size is fraction of the full font size.
   property real fontSizeMini: 0.7; [cite: 312]

   // Add the font property, similar to Jianpu
   property var fontNoteNumbers : "Parnumation"

   id: noteNumbers
   //4.4 title: "Note Numbers"
   //4.4 categoryCode: "composing-arranging-tools"
   //4.4 thumbnailName: "note_names.png"
   Component.onCompleted : {
      if (mscoreMajorVersion >= 4 && mscoreMinorVersion <= 3) {
         noteNumbers.title = "Note Numbers"
         noteNumbers.categoryCode = "composing-arranging-tools"
         noteNumbers.thumbnailName = "note_names.png"
      }
   }

   function nameChord (notes, text, small) {
      var sep = "\n";   // change to "," if you want them horizontally (anybody?) [cite: 313]
      var oct = ""; [cite: 314]
      var name;
      // Add font face tag
      var fontFaceTag="<font face=\""+fontNoteNumbers+"\"/>";

      for (var i = 0; i < notes.length; i++) {
         if (!notes[i].visible)
            continue // skip invisible notes
         if (text.text) // only if text isn't empty
            text.text = sep + text.text; [cite: 315]
         if (small)
            text.fontSize *= fontSizeMini [cite: 315]
         if (typeof notes[i].tpc === "undefined") // like for grace notes ?!?
            return [cite: 316]
         switch (notes[i].tpc) {
            case -1: name = "♭♭4"; [cite: 317]
            case  0: name = "♭♭1"; [cite: 318]
            case  1: name = "♭♭5"; [cite: 319]
            case  2: name = "♭♭2"; [cite: 320]
            case  3: name = "♭♭6"; [cite: 321]
            case  4: name = "♭♭3"; [cite: 322]
            case  5: name = "♭♭7"; [cite: 323]

            case  6: name = "♭4"; [cite: 324]
            case  7: name = "♭1"; [cite: 325]
            case  8: name = "♭5"; [cite: 326]
            case  9: name = "♭2"; [cite: 327]
            case 10: name = "♭6"; [cite: 328]
            case 11: name = "♭4"; [cite: 329]
            case 12: name = "♭7"; [cite: 330]

            case 13: name = "4"; [cite: 331]
            case 14: name = "1"; [cite: 332]
            case 15: name = "5"; [cite: 333]
            case 16: name = "2"; [cite: 334]
            case 17: name = "6"; [cite: 335]
            case 18: name = "3"; [cite: 336]
            case 19: name = "7"; [cite: 337]

            case 20: name = "♯4"; [cite: 338]
            case 21: name = "♯1"; [cite: 339]
            case 22: name = "♯5"; [cite: 340]
            case 23: name = "♯2"; [cite: 341]
            case 24: name = "♯6"; [cite: 342]
            case 25: name = "♯3"; [cite: 343]
            case 26: name = "♯7"; [cite: 344]

            case 27: name = "♯♯4"; [cite: 345]
            case 28: name = "♯♯1"; [cite: 346]
            case 29: name = "♯♯5"; [cite: 347]
            case 30: name = "♯♯2"; [cite: 348]
            case 31: name = "♯♯6"; [cite: 349]
            case 32: name = "♯♯3"; [cite: 350]
            case 33: name = "♯♯7"; [cite: 351]
            default: name = qsTr("?")   + text.text; [cite: 352]
            break;
         } // end switch tpc

         // octave, middle C being C4
         //oct = (Math.floor(notes[i].pitch / 12) - 1)
         // or
         //oct = (Math.floor(notes[i].ppitch / 12) - 1)
         // or even this, similar to the Helmholtz system but one octave up
         //var octaveTextPostfix = [",,,,,", ",,,,", ",,,", ",,", ",", "", "'", "''",
         // "'''", "''''", "'''''"]; [cite: 353]
         //oct = octaveTextPostfix[Math.floor(notes[i].pitch / 12)];
         text.text = fontFaceTag + name + oct + text.text // Apply the font face tag

// change below false to true for courtesy- and microtonal accidentals
// you might need to come up with suitable translations
// only #, b, natural and possibly also ## seem to be available in UNICODE
         if (false) {
            switch (notes[i].userAccidental) {
               case  0: break; [cite: 354]
               case  1: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp") + text.text; break; [cite: 355]
               case  2: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat") + text.text; break; [cite: 356]
               case  3: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Double sharp") + text.text; break; [cite: 357]
               case  4: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Double flat") + text.text; break; [cite: 358]
               case  5: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural") + text.text; break; [cite: 359]
               case  6: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat-slash") + text.text; break; [cite: 360]
               case  7: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat-slash2") + text.text; break; [cite: 361]
               case  8: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Mirrored-flat2") + text.text; break; [cite: 362]
               case  9: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Mirrored-flat") + text.text; break; [cite: 363]
               case 10: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Mirrored-flat-slash") + text.text; break; [cite: 364]
               case 11: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat-flat-slash") + text.text; break; [cite: 365]
               case 12: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash") + text.text; break; [cite: 366]
               case 13: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash2") + text.text; break; [cite: 367]
               case 14: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash3") + text.text; break; [cite: 368]
               case 15: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash4") + text.text; break; [cite: 369]
               case 16: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp arrow up") + text.text; break; [cite: 370]
               case 17: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp arrow down") + text.text; break; [cite: 371]
               case 18: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp arrow both") + text.text; break; [cite: 372]
               case 19: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat arrow up") + text.text; break; [cite: 373]
               case 20: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat arrow down") + text.text; break; [cite: 374]
               case 21: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat arrow both") + text.text; break; [cite: 375]
               case 22: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural arrow down") + text.text; break; [cite: 376]
               case 23: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural arrow up") + text.text; break; [cite: 377]
               case 24: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural arrow both") + text.text; break; [cite: 378]
               case 25: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sori") + text.text; break; [cite: 379]
               case 26: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Koron") + text.text; break; [cite: 380]
               default: text.text = qsTr("?") + text.text; break;
            }  // end switch userAccidental
         }  // end if courtesy- and microtonal accidentals
      }  // end for note
   }

   function renderGraceNoteNames (cursor, list, text, small) {
      if (list.length > 0) {     // Check for existence. [cite: 381]
// Now render grace note's names...
         for (var chordNum = 0; chordNum < list.length; chordNum++) {
            // iterate through all grace chords
            var chord = list[chordNum]; [cite: 382]
// Set note text, grace notes are shown a bit smaller
            nameChord(chord.notes, text, small)
            if (text.text)
               cursor.add(text)
            // X position the note name over the grace chord
            text.offsetX = chord.posX
            switch (cursor.voice) { [cite: 383]
               case 1: case 3: text.placement = Placement.BELOW; [cite: 384]
               break;
            }

            // If we consume a STAFF_TEXT we must manufacture a new one.
            if (text.text) [cite: 385]
               text = newElement(Element.STAFF_TEXT); [cite: 386]
// Make another STAFF_TEXT
         }
      }
      return text
   }

   onRun: {
      curScore.startCmd(); [cite: 387]
      var cursor = curScore.newCursor();
      var startStaff;
      var endStaff;
      var endTick;
      var fullScore = false;
      cursor.rewind(Cursor.SELECTION_START); [cite: 388]
      if (!cursor.segment) { // no selection
         fullScore = true;
         startStaff = 0; [cite: 389]
// start with 1st staff
         endStaff  = curScore.nstaves - 1; [cite: 390]
// and end with last
      } else {
         startStaff = cursor.staffIdx; [cite: 391]
         cursor.rewind(Cursor.SELECTION_END);
         if (cursor.tick === 0) {
            // this happens when the selection includes
            // the last measure of the score.
// rewind(Cursor.SELECTION_END) goes behind the last segment
            // (where there's none) and sets tick=0
            endTick = curScore.lastSegment.tick + 1; [cite: 393]
         } else {
            endTick = cursor.tick; [cite: 394]
         }
         endStaff = cursor.staffIdx; [cite: 395]
      }
      console.log(startStaff + " - " + endStaff + " - " + endTick)

      for (var staff = startStaff; staff <= endStaff; staff++) { [cite: 395]
         for (var voice = 0; voice < 4; voice++) {
            cursor.rewind(Cursor.SELECTION_START); [cite: 396]
// beginning of selection
            cursor.voice    = voice; [cite: 397]
            cursor.staffIdx = staff;

            if (fullScore)  // no selection
               cursor.rewind(Cursor.SCORE_START); [cite: 398]
// beginning of score
            while (cursor.segment && (fullScore || cursor.tick < endTick)) {
               if (cursor.element && cursor.element.type === Element.CHORD) {
                  var text = newElement(Element.STAFF_TEXT); [cite: 399]
// Make a STAFF_TEXT

                  // First...we need to scan grace notes for existence and break them
                  // into their appropriate lists with the correct ordering of notes.
                  var leadingLifo = Array();   // List for leading grace notes [cite: 400]
                  var trailingFifo = Array(); [cite: 401]
// List for trailing grace notes
                  var graceChords = cursor.element.graceNotes; [cite: 402]
// Build separate lists of leading and trailing grace note chords.
                  if (graceChords.length > 0) { [cite: 403]
                     for (var chordNum = 0; chordNum < graceChords.length; chordNum++) {
                        var noteType = graceChords[chordNum].notes[0].noteType
                        if (noteType === NoteType.GRACE8_AFTER || noteType === NoteType.GRACE16_AFTER ||
                           noteType === NoteType.GRACE32_AFTER) { [cite: 404]
                           trailingFifo.unshift(graceChords[chordNum])
                        } else {
                           leadingLifo.push(graceChords[chordNum]) [cite: 405]
                        }
                     }
                  }

                  // Next process the leading grace notes, should they exist...
                  text = renderGraceNoteNames(cursor, leadingLifo, text, true) [cite: 406]

                  // Now handle the note names on the main chord...
                  var notes = cursor.element.notes; [cite: 407]
                  nameChord(notes, text, false);
                  if (text.text)
                     cursor.add(text); [cite: 408]
                  switch (cursor.voice) {
                     case 1: case 3: text.placement = Placement.BELOW; [cite: 409]
                     break;
                  }

                  if (text.text)
                     text = newElement(Element.STAFF_TEXT) // Make another STAFF_TEXT object

                  // Finally process trailing grace notes if they exist...
                  text = renderGraceNoteNames(cursor, trailingFifo, text, true)
               } // end if CHORD [cite: 410]
               cursor.next(); [cite: 411]
            } // end while segment
         } // end for voice
      } // end for staff

      curScore.endCmd(); [cite: 412]
      (typeof(quit) === 'undefined' ? Qt.quit : quit)()
   } // end onRun
}
