//=============================================================================
//  MuseScore
//  Music Composition & Notation
//
//  Solmisasi for MuseScore (dimodifikasi dari Note Names Plugin)
//  https://github.com/seltinusjulio/solmisasi-musescore
//
//  Copyright (C) 2012 Werner Schweer
//  Copyright (C) 2013 - 2021 Joachim Schmitz
//  Copyright (C) 2014 Jörn Eichler
//  Copyright (C) 2020 Johan Temmerman
//  Copyright (C) 2025 Angelo Seltinus, OFMCap / Seltinus Julio
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
   description: "Plugin ini menampilkan not angka (solmisasi) di atas not balok. Untuk fungsi penuh memerlukan font Parnumation."
   menuPath: "Plugins.Notes." + "Solmisasi"

   // Small note name size is fraction of the full font size.
   property real fontSizeMini: 0.7;

   id: noteNames
   //4.4 title: "Solmisasi"
   //4.4 categoryCode: "composing-arranging-tools"
   //4.4 thumbnailName: "solmisasi.png"
   Component.onCompleted : {
      if (mscoreMajorVersion >= 4 && mscoreMinorVersion <= 3) {
         noteNames.title = "Solmisasi"
         noteNames.categoryCode = "composing-arranging-tools"
         noteNames.thumbnailName = "solmisasi.png"
      }
   }

   function nameChord (notes, text, small) {
      var sep = "\n";   // change to "," if you want them horizontally (anybody?)
      // var oct = "";
      var name;
      for (var i = 0; i < notes.length; i++) {
         if (!notes[i].visible)
            continue // skip invisible notes
         if (text.text) // only if text isn't empty
            text.text = sep + text.text;
         if (small)
            text.fontSize *= fontSizeMini
         if (typeof notes[i].tpc === "undefined") // like for grace notes ?!?
            return
         switch (notes[i].tpc) {
            case -1: name = mscoreMajorVersion >= 4 ? qsTr("F♭♭") : qsTranslate("InspectorAmbitus", "3"); break;
            case  0: name = mscoreMajorVersion >= 4 ? qsTr("C♭♭") : qsTranslate("InspectorAmbitus", "\\7"); break;
            case  1: name = mscoreMajorVersion >= 4 ? qsTr("G♭♭") : qsTranslate("InspectorAmbitus", "4"); break;
            case  2: name = mscoreMajorVersion >= 4 ? qsTr("D♭♭") : qsTranslate("InspectorAmbitus", "1"); break;
            case  3: name = mscoreMajorVersion >= 4 ? qsTr("A♭♭") : qsTranslate("InspectorAmbitus", "5"); break;
            case  4: name = mscoreMajorVersion >= 4 ? qsTr("E♭♭") : qsTranslate("InspectorAmbitus", "2"); break;
            case  5: name = mscoreMajorVersion >= 4 ? qsTr("B♭♭") : qsTranslate("InspectorAmbitus", "6"); break;

            case  6: name = mscoreMajorVersion >= 4 ? qsTr("F♭") : qsTranslate("InspectorAmbitus", "4"); break;
            case  7: name = mscoreMajorVersion >= 4 ? qsTr("C♭") : qsTranslate("InspectorAmbitus", "7"); break;
            case  8: name = mscoreMajorVersion >= 4 ? qsTr("G♭") : qsTranslate("InspectorAmbitus", "/4"); break;
            case  9: name = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/instruments:db-piccolo traitName" : "InspectorAmbitus", "/1"); break;
            case 10: name = qsTranslate(mscoreMajorVersion >= 4 ? "EditPitchBase" : "InspectorAmbitus", "/5"); break;
            case 11: name = qsTranslate(mscoreMajorVersion >= 4 ? "EditPitchBase" : "InspectorAmbitus", "/2"); break;
            case 12: name = qsTranslate(mscoreMajorVersion >= 4 ? "EditPitchBase" : "InspectorAmbitus", "\\7"); break;

            case 13: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "4"); break;
            case 14: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "1"); break;
            case 15: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "5"); break;
            case 16: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "2"); break;
            case 17: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "6"); break;
            case 18: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "3"); break;
            case 19: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "7"); break;

            case 20: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "/4"); break;
            case 21: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "/1"); break;
            case 22: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "/5"); break;
            case 23: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "/2"); break;
            case 24: name = qsTranslate(mscoreMajorVersion >= 4 ? "global" : "InspectorAmbitus", "\\7"); break;
            case 25: name = mscoreMajorVersion >= 4 ? qsTr("E♯") : qsTranslate("InspectorAmbitus", "4"); break;
            case 26: name = mscoreMajorVersion >= 4 ? qsTr("B♯") : qsTranslate("InspectorAmbitus", "!"); break;

            case 27: name = mscoreMajorVersion >= 4 ? qsTr("F♯♯") : qsTranslate("InspectorAmbitus", "5"); break;
            case 28: name = mscoreMajorVersion >= 4 ? qsTr("C♯♯") : qsTranslate("InspectorAmbitus", "2"); break;
            case 29: name = mscoreMajorVersion >= 4 ? qsTr("G♯♯") : qsTranslate("InspectorAmbitus", "6"); break;
            case 30: name = mscoreMajorVersion >= 4 ? qsTr("D♯♯") : qsTranslate("InspectorAmbitus", "3"); break;
            case 31: name = mscoreMajorVersion >= 4 ? qsTr("A♯♯") : qsTranslate("InspectorAmbitus", "7"); break;
            case 32: name = mscoreMajorVersion >= 4 ? qsTr("E♯♯") : qsTranslate("InspectorAmbitus", "/4"); break;
            case 33: name = mscoreMajorVersion >= 4 ? qsTr("B♯♯") : qsTranslate("InspectorAmbitus", "/1"); break;
            default: name = qsTr("?")   + text.text; break;
         } // end switch tpc

         let octavePrefix = ""; // Variabel untuk menyimpan prefix oktaf (misalnya "a", "s", "9", "8")
         const currentPitch = notes[i].pitch; // Gunakan notes[i].pitch untuk menentukan oktaf MIDI

         // MIDI Pitch (contoh, C4 = 60):
         // C0 = 12, C1 = 24, C2 = 36, C3 = 48, C4 = 60, C5 = 72, C6 = 84, C7 = 96, C8 = 108

         if (currentPitch >= 60 && currentPitch < 72) {
           // Rentang untuk oktaf C4 (pitch 60 hingga 71)
           // Sesuai pola: C4=1, D4=2, E4=3. Tidak ada prefix.
           octavePrefix = ""; // Prefix kosong
         } else if (currentPitch >= 72 && currentPitch < 84) {
           // Rentang untuk oktaf C5 (pitch 72 hingga 83)
           // Sesuai pola: C5=a1, D5=a2, E5=a3. Prefix 'a'.
           octavePrefix = "a";
         } else if (currentPitch >= 48 && currentPitch < 60) {
           // Rentang untuk oktaf C3 (pitch 48 hingga 59)
           // Sesuai pola: C3=s1, D3=s2, E3=s3. Prefix 's'.
           octavePrefix = "s";
         } else if (currentPitch >= 84 && currentPitch < 96) {
           // Rentang untuk oktaf C6 (pitch 84 hingga 95)
           // Sesuai pola: C6=91, D6=92, E6=93. Prefix '9'.
           octavePrefix = "9";
         } else if (currentPitch >= 36 && currentPitch < 48) {
           // Rentang untuk oktaf C2 (pitch 36 hingga 47)
           // Sesuai pola: C2=81, D2=82, E2=83. Prefix '8'.
           octavePrefix = "8";
         } else {
           // Untuk oktaf lain yang tidak secara eksplisit didefinisikan dalam pola Anda.
           // Anda bisa memilih bagaimana menampilkannya:
           // 1. Tidak menambahkan prefix sama sekali (hanya angka dasar not):
           //    octavePrefix = "";
           // 2. Menambahkan angka oktaf standar sebagai prefix (misal C1 -> 11, C0 -> 01):
           //    octavePrefix = (Math.floor(currentPitch / 12) - 1).toString(); // Ini akan memberi prefix angka oktaf MIDI
           // 3. Menambahkan '?' untuk menandai oktaf yang tidak dipetakan:
           octavePrefix = "?";
         }

         // Gabungkan prefix oktaf dengan 'name' (representasi dasar not)
         // Sesuai pola: prefix + name
         const finalNoteRepresentation = octavePrefix + name;

         // Akhirnya, setel text.text dengan representasi not final.
         // Jika Anda memiliki 'text.text' yang lama dan ingin dipertahankan di akhir (seperti string konteks atau apa pun):
         // text.text = finalNoteRepresentation + text.text;
         // Jika 'text.text' hanya digunakan untuk hasil ini:
         text.text = finalNoteRepresentation;

         // octave, middle C being C4
         //oct = (Math.floor(notes[i].pitch / 12) - 1)
         // or
         //oct = (Math.floor(notes[i].ppitch / 12) - 1)
         // or even this, similar to the Helmholtz system but one octave up
         //var octaveTextPostfix = [",,,,,", ",,,,", ",,,", ",,", ",", "", "'", "''", "'''", "''''", "'''''"];
         //oct = octaveTextPostfix[Math.floor(notes[i].pitch / 12)];
         //text.text = name + oct + text.text

// change below false to true for courtesy- and microtonal accidentals
// you might need to come up with suitable translations
// only #, b, natural and possibly also ## seem to be available in UNICODE
         if (false) {
            switch (notes[i].userAccidental) {
               case  0: break;
               case  1: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp") + text.text; break;
               case  2: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat") + text.text; break;
               case  3: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Double sharp") + text.text; break;
               case  4: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Double flat") + text.text; break;
               case  5: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural") + text.text; break;
               case  6: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat-slash") + text.text; break;
               case  7: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat-slash2") + text.text; break;
               case  8: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Mirrored-flat2") + text.text; break;
               case  9: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Mirrored-flat") + text.text; break;
               case 10: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Mirrored-flat-slash") + text.text; break;
               case 11: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat-flat-slash") + text.text; break;
               case 12: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash") + text.text; break;
               case 13: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash2") + text.text; break;
               case 14: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash3") + text.text; break;
               case 15: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp-slash4") + text.text; break;
               case 16: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp arrow up") + text.text; break;
               case 17: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp arrow down") + text.text; break;
               case 18: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sharp arrow both") + text.text; break;
               case 19: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat arrow up") + text.text; break;
               case 20: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat arrow down") + text.text; break;
               case 21: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Flat arrow both") + text.text; break;
               case 22: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural arrow down") + text.text; break;
               case 23: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural arrow up") + text.text; break;
               case 24: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Natural arrow both") + text.text; break;
               case 25: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Sori") + text.text; break;
               case 26: text.text = qsTranslate(mscoreMajorVersion >= 4 ? "engraving/sym" : "accidental", "Koron") + text.text; break;
               default: text.text = qsTr("?") + text.text; break;
            }  // end switch userAccidental
         }  // end if courtesy- and microtonal accidentals
      }  // end for note
   }

   function renderGraceNoteNames (cursor, list, text, small) {
      if (list.length > 0) {     // Check for existence.
         // Now render grace note's names...
         for (var chordNum = 0; chordNum < list.length; chordNum++) {
            // iterate through all grace chords
            var chord = list[chordNum];
            // Set note text, grace notes are shown a bit smaller
            nameChord(chord.notes, text, small)
            if (text.text)
               cursor.add(text)
            // X position the note name over the grace chord
            text.offsetX = chord.posX
            switch (cursor.voice) {
               case 1: case 3: text.placement = Placement.BELOW; break;
            }

            // If we consume a STAFF_TEXT we must manufacture a new one.
            if (text.text)
               text = newElement(Element.STAFF_TEXT);    // Make another STAFF_TEXT
         }
      }
      return text
   }

   onRun: {
      curScore.startCmd();

      var cursor = curScore.newCursor();
      var startStaff;
      var endStaff;
      var endTick;
      var fullScore = false;
      cursor.rewind(Cursor.SELECTION_START);
      if (!cursor.segment) { // no selection
         fullScore = true;
         startStaff = 0; // start with 1st staff
         endStaff  = curScore.nstaves - 1; // and end with last
      } else {
         startStaff = cursor.staffIdx;
         cursor.rewind(Cursor.SELECTION_END);
         if (cursor.tick === 0) {
            // this happens when the selection includes
            // the last measure of the score.
            // rewind(Cursor.SELECTION_END) goes behind the last segment
            // (where there's none) and sets tick=0
            endTick = curScore.lastSegment.tick + 1;
         } else {
            endTick = cursor.tick;
         }
         endStaff = cursor.staffIdx;
      }
      console.log(startStaff + " - " + endStaff + " - " + endTick)

      for (var staff = startStaff; staff <= endStaff; staff++) {
         for (var voice = 0; voice < 4; voice++) {
            cursor.rewind(Cursor.SELECTION_START); // beginning of selection
            cursor.voice    = voice;
            cursor.staffIdx = staff;

            if (fullScore)  // no selection
               cursor.rewind(Cursor.SCORE_START); // beginning of score
            while (cursor.segment && (fullScore || cursor.tick < endTick)) {
               if (cursor.element && cursor.element.type === Element.CHORD) {
                  var text = newElement(Element.STAFF_TEXT);      // Make a STAFF_TEXT
                  // text.placement = Placement.BELOW;
                  // text.y = 10;

                  // First...we need to scan grace notes for existence and break them
                  // into their appropriate lists with the correct ordering of notes.
                  var leadingLifo = Array();   // List for leading grace notes
                  var trailingFifo = Array();  // List for trailing grace notes
                  var graceChords = cursor.element.graceNotes;
                  // Build separate lists of leading and trailing grace note chords.
                  if (graceChords.length > 0) {
                     for (var chordNum = 0; chordNum < graceChords.length; chordNum++) {
                        var noteType = graceChords[chordNum].notes[0].noteType
                        if (noteType === NoteType.GRACE8_AFTER || noteType === NoteType.GRACE16_AFTER ||
                              noteType === NoteType.GRACE32_AFTER) {
                           trailingFifo.unshift(graceChords[chordNum])
                        } else {
                           leadingLifo.push(graceChords[chordNum])
                        }
                     }
                  }

                  // Next process the leading grace notes, should they exist...
                  text = renderGraceNoteNames(cursor, leadingLifo, text, true)

                  // Now handle the note names on the main chord...
                  var notes = cursor.element.notes;
                  nameChord(notes, text, false);
                  if (text.text)
                     cursor.add(text);

                  switch (cursor.voice) {
                     case 1: case 3: text.placement = Placement.BELOW; break;
                  }

                  if (text.text)
                     text = newElement(Element.STAFF_TEXT) // Make another STAFF_TEXT object

                  // Finally process trailing grace notes if they exist...
                  text = renderGraceNoteNames(cursor, trailingFifo, text, true)
               } // end if CHORD
               cursor.next();
            } // end while segment
         } // end for voice
      } // end for staff

      curScore.endCmd();
      (typeof(quit) === 'undefined' ? Qt.quit : quit)()
   } // end onRun
}
