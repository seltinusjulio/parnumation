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
   menuPath: "Plugins.Notes." + "Note Numbers"

   // Small note name size is fraction of the full font size.
   property real fontSizeMini: 0.7;
   [cite_start]// Tambahkan properti ini untuk nama font kustom [cite: 1]
   property var customFontName: "Arial"; [cite_start]// Ganti "Arial" dengan nama font yang Anda inginkan [cite: 1]

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
      var sep = "\n";   // change to "," if you want them horizontally (anybody?)
      var oct = "";
      var name;
      for (var i = 0; i < notes.length; i++) {
         if (!notes[i].visible)
            continue // skip invisible notes
         if (text.text) // only if text isn't empty, prepend separator
            text.text = sep + text.text;

         var pitch = notes[i].pitch;
         var noteName = notes[i].name; // e.g. Note.C
         var noteAccid = notes[i].accidental; // e.g. Accidental.FLAT, Accidental.SHARP

         // Check if this note is tied to a previous note
         if (notes[i].tieBack != null)
         {
            // If the note is tied to a previous note, its name is empty
            name = "";
         } else {
            // Note is not tied, determine its name
            if (mscoreMajorVersion >= 4) { // MuseScore 4.x
               switch (noteName) {
                  case Note.C: oct = "C"; break;
                  case Note.D: oct = "D"; break;
                  case Note.E: oct = "E"; break;
                  case Note.F: oct = "F"; break;
                  case Note.G: oct = "G"; break;
                  case Note.A: oct = "A"; break;
                  case Note.B: oct = "B"; break;
               }
               // Numbers C=1, D=2, E=3, F=4, G=5, A=6, B=7
               switch (noteName) {
                  case Note.C: name = "1"; break;
                  case Note.D: name = "2"; break;
                  case Note.E: name = "3"; break;
                  case Note.F: name = "4"; break;
                  case Note.G: name = "5"; break;
                  case Note.A: name = "6"; break;
                  case Note.B: name = "7"; break;
               }
            } else { // MuseScore 3.x
               switch (noteName) {
                  case Note.C: oct = qsTranslate("InspectorAmbitus", "C"); break;
                  case Note.D: oct = qsTranslate("InspectorAmbitus", "D"); break;
                  case Note.E: oct = qsTranslate("InspectorAmbitus", "E"); break;
                  case Note.F: oct = qsTranslate("InspectorAmbitus", "F"); break;
                  case Note.G: oct = qsTranslate("InspectorAmbitus", "G"); break;
                  case Note.A: oct = qsTranslate("InspectorAmbitus", "A"); break;
                  case Note.B: oct = qsTranslate("InspectorAmbitus", "B"); break;
               }
               switch (noteName) {
                  case Note.C: name = "1"; break;
                  case Note.D: name = "2"; break;
                  case Note.E: name = "3"; break;
                  case Note.F: name = "4"; break;
                  case Note.G: name = "5"; break;
                  case Note.A: name = "6"; break;
                  case Note.B: name = "7"; break;
               }
            }
            // Add accidentals prefix for numbers
            switch (noteAccid) {
               case Accidental.DBL_FLAT: name = "♭♭" + name; break;
               case Accidental.FLAT:     name = "♭" + name; break;
               case Accidental.NATURAL:  /* name = "♮" + name; */ break; // Usually not displayed
               case Accidental.SHARP:    name = "♯" + name; break;
               case Accidental.DBL_SHARP:name = "♯♯" + name; break;
               // Handling of other accidentals (e.g. microtonal) can be added here
            }

            // Uncomment this if you want to use accidental names instead of symbols
            /*
            if (false) { // set to 'true' to enable
               var accidName;
               switch (noteAccid) {
                  case Accidental.DBL_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Double flat") : qsTranslate("engraving/sym", "Double flat"); break;
                  case Accidental.FLAT:     accidName = mscoreMajorVersion >= 4 ? qsTr("Flat") : qsTranslate("engraving/sym", "Flat"); break;
                  case Accidental.NATURAL:  accidName = mscoreMajorVersion >= 4 ? qsTr("Natural") : qsTranslate("engraving/sym", "Natural"); break;
                  case Accidental.SHARP:    accidName = mscoreMajorVersion >= 4 ? qsTr("Sharp") : qsTranslate("engraving/sym", "Sharp"); break;
                  case Accidental.DBL_SHARP:accidName = mscoreMajorVersion >= 4 ? qsTr("Double sharp") : qsTranslate("engraving/sym", "Double sharp"); break;
                  case Accidental.FLAT_SLASH: accidName = mscoreMajorVersion >= 4 ? qsTr("Flat slash") : qsTranslate("engraving/sym", "Flat slash"); break;
                  case Accidental.FLAT_SLASH_SLASH: accidName = mscoreMajorVersion >= 4 ? qsTr("Flat slash slash") : qsTranslate("engraving/sym", "Flat slash slash"); break;
                  case Accidental.TRIPLE_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Triple flat") : qsTranslate("engraving/sym", "Triple flat"); break;
                  case Accidental.TRIPLE_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Triple sharp") : qsTranslate("engraving/sym", "Triple sharp"); break;
                  case Accidental.SHARP_SLASH: accidName = mscoreMajorVersion >= 4 ? qsTr("Sharp slash") : qsTranslate("engraving/sym", "Sharp slash"); break;
                  case Accidental.NATURAL_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Natural flat") : qsTranslate("engraving/sym", "Natural flat"); break;
                  case Accidental.NATURAL_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Natural sharp") : qsTranslate("engraving/sym", "Natural sharp"); break;
                  case Accidental.SORI: accidName = mscoreMajorVersion >= 4 ? qsTr("Sori") : qsTranslate("engraving/sym", "Sori"); break;
                  case Accidental.KORON: accidName = mscoreMajorVersion >= 4 ? qsTr("Koron") : qsTranslate("engraving/sym", "Koron"); break;
                  case Accidental.KORON_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Koron flat") : qsTranslate("engraving/sym", "Koron flat"); break;
                  case Accidental.KORON_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Koron sharp") : qsTranslate("engraving/sym", "Koron sharp"); break;
                  case Accidental.DOUBLE_KORON: accidName = mscoreMajorVersion >= 4 ? qsTr("Double koron") : qsTranslate("engraving/sym", "Double koron"); break;
                  case Accidental.DOUBLE_SORI: accidName = mscoreMajorVersion >= 4 ? qsTr("Double sori") : qsTranslate("engraving/sym", "Double sori"); break;
                  case Accidental.FIVE_QUARTER_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Five-quarter flat") : qsTranslate("engraving/sym", "Five-quarter flat"); break;
                  case Accidental.THREE_QUARTER_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Three-quarter flat") : qsTranslate("engraving/sym", "Three-quarter flat"); break;
                  case Accidental.QUARTER_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Quarter flat") : qsTranslate("engraving/sym", "Quarter flat"); break;
                  case Accidental.QUARTER_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Quarter sharp") : qsTranslate("engraving/sym", "Quarter sharp"); break;
                  case Accidental.THREE_QUARTER_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Three-quarter sharp") : qsTranslate("engraving/sym", "Three-quarter sharp"); break;
                  case Accidental.FIVE_QUARTER_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Five-quarter sharp") : qsTranslate("engraving/sym", "Five-quarter sharp"); break;
                  case Accidental.SOMI: accidName = mscoreMajorVersion >= 4 ? qsTr("Somi") : qsTranslate("engraving/sym", "Somi"); break;
                  case Accidental.EIGHTH_FLAT: accidName = mscoreMajorVersion >= 4 ? qsTr("Eighth flat") : qsTranslate("engraving/sym", "Eighth flat"); break;
                  case Accidental.EIGHTH_SHARP: accidName = mscoreMajorVersion >= 4 ? qsTr("Eighth sharp") : qsTranslate("engraving/sym", "Eighth sharp"); break;
                  case Accidental.ARROW_UP: accidName = mscoreMajorVersion >= 4 ? qsTr("Arrow up") : qsTranslate("engraving/sym", "Arrow up"); break;
                  case Accidental.ARROW_DOWN: accidName = mscoreMajorVersion >= 4 ? qsTr("Arrow down") : qsTranslate("engraving/sym", "Arrow down"); break;
                  case Accidental.ARROW_UP_DOWN: accidName = mscoreMajorVersion >= 4 ? qsTr("Arrow up down") : qsTranslate("engraving/sym", "Arrow up down"); break;
                  case Accidental.PLUS: accidName = mscoreMajorVersion >= 4 ? qsTr("Plus") : qsTranslate("engraving/sym", "Plus"); break;
                  case Accidental.MINUS: accidName = mscoreMajorVersion >= 4 ? qsTr("Minus") : qsTranslate("engraving/sym", "Minus"); break;
                  default: accidName = ""; break;
               }
               if (accidName)
                  name = accidName + " " + name; // add space for readability
            }
            */

         }
         [cite_start]// Tambahkan tag HTML font di sini, membungkus nama yang dihasilkan [cite: 1]
         text.text = "<font face=\"" + customFontName + "\">" + name + "</font>" + text.text;
      }
      if (small)
         text.fontSize *= fontSizeMini;
   }

   function renderGraceNoteNames(cursor, queue, text, small) {
      while (!queue.empty()) {
         var graceChord = queue.pop();
         if (graceChord.visible) {
            cursor.add(newElement(Element.GRACE_NOTE_GROUP)); // Add a group for the grace notes

            var notes = graceChord.notes;
            var saved = text.text;
            text.text = ""; // clear text, so the nameChord generates only for this grace note.
            nameChord(notes, text, small);

            [cite_start]// Jika text.text tidak kosong, tambahkan tag font di sini untuk grace notes [cite: 1]
            if (text.text) {
                text.text = "<font face=\"" + customFontName + "\">" + text.text + "</font>";
            }

            cursor.add(text); // Add current grace note text
            text = newElement(Element.STAFF_TEXT); // Make another STAFF_TEXT object for next grace note
            text.text = saved; // restore text, so next nameChord prepend with separator.
         }
      }
      return text;
   }

   function onRun() {
      if (typeof curScore === 'undefined')
         (typeof(quit) === 'undefined' ? Qt.quit : quit)() // Exit plugin if no score is open

      curScore.startCmd();

      var cursor = curScore.newCursor();
      var startStaff;
      var endStaff;
      var endTick;
      var fullScore = false;

      cursor.rewind(0); // rewind to start of score
      if (!cursor.segment) { // no selection
         fullScore = true;
         startStaff = 0; // start with 1st staff
         endStaff  = curScore.nstaves - 1; // and end with last
      } else {
         startStaff = cursor.staffIdx;
         cursor.rewind(1); // rewind to start of selection
         endTick = cursor.tick;
         cursor.rewind(2); // rewind to end of selection
         if (cursor.tick == 0) { // selection is only part of a segment
            endTick = curScore.lastSegment.tick + 1;
         } else {
            endTick = cursor.tick;
         }
         endStaff   = cursor.staffIdx;
      }

      for (var staff = startStaff; staff <= endStaff; staff++) {
         for (var voice = 0; voice < 4; voice++) {
            cursor.rewind(0); // beginning of score
            cursor.voice    = voice;
            cursor.staffIdx = staff;

            while (cursor.segment && (fullScore || cursor.tick < endTick)) {
               if (cursor.element && cursor.element.type === Element.CHORD) {
                  var text = newElement(Element.STAFF_TEXT);
                  text.placement = Placement.BELOW;

                  // First, process grace notes that exist with this chord
                  var leadingLifo = new Array(); // LIFO queue for leading grace notes
                  var trailingFifo = new Array(); // FIFO queue for trailing grace notes
                  for (var chordNum = 0; chordNum < cursor.element.graceNotes.length; chordNum++) {
                     if (cursor.element.graceNotes[chordNum].visible) {
                        var noteType = cursor.element.graceNotes[chordNum].notes[0].noteType
                        if (noteType === NoteType.GRACE8_AFTER || noteType === NoteType.GRACE16_AFTER ||
                              noteType === NoteType.GRACE32_AFTER) {
                           trailingFifo.unshift(cursor.element.graceNotes[chordNum])
                        } else {
                           leadingLifo.push(cursor.element.graceNotes[chordNum])
                        }
                     }
                  }

                  // Next process the leading grace notes, should they exist...
                  text = renderGraceNoteNames(cursor, leadingLifo, text, true)

                  // Now handle the note names on the main chord...
                  var notes = cursor.element.notes;
                  nameChord(notes, text, false);
                  [cite_start]// Tambahkan tag font di sini untuk not utama [cite: 1]
                  if (text.text) { // Pastikan ada teks sebelum dimodifikasi
                      text.text = "<font face=\"" + customFontName + "\">" + text.text + "</font>";
                  }

                  if (text.text)
                     cursor.add(text);

                  switch (cursor.voice) {
                     case 1: case 3: text.placement = Placement.BELOW; break;
                  }

                  if (text.text)
                     text = newElement(Element.STAFF_TEXT) // Make another STAFF_TEXT object

                  // Finally process trailing grace notes if they exist...
                  text = renderGraceNoteNames(cursor, trailingFifo, text, true)
               [cite_start]} else if (cursor.isRest) { // Tambahkan '0' untuk tanda istirahat [cite: 1]
                   var text = newElement(Element.STAFF_TEXT);
                   text.placement = Placement.BELOW; // Tempatkan di bawah tanda istirahat
                   text.text = "<font face=\"" + customFontName + "\">0</font>"; [cite_start]// Tampilkan '0' dengan font kustom [cite: 1]
                   cursor.add(text);
               }
               cursor.next();
            } // end while segment
         } // end for voice
      } // end for staff

      curScore.endCmd();
      (typeof(quit) === 'undefined' ? Qt.quit : quit)()
   } // end onRun
}
