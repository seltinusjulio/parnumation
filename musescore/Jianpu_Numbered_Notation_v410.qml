//==============================================
//  MuseScore
//
//  Jianpu Numbered Notation plugin Ver4  for MuseScore Ver. 4
// 
//  Copyright (C)2020 Hiroshi Tachibana
//  Copyright (C)2023 Joachim Schmitz
//  Copyright (C)2023 Hiroshi Tachibana
//
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.9
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import MuseScore 3.0
//import FileIO 1.0

import Qt.labs.settings 1.0

MuseScore {
  menuPath: "Plugins.Jianpu Numbered Notation" // 
  version: "4.1"
  description: qsTr("Jianpu Numbered Notation")
  pluginType: "dialog"

  id: window
  width:285  // menu window size
  height:285

  Component.onCompleted : {
    if (mscoreMajorVersion >= 4) {
      window.title = "Jianpu Numbered Notation";
    }
  }

  ExclusiveGroup { id: exclusiveGroupKey }

  property var fontJianpu : "Arial Narrow"              ////        Jianpu Font Name
  
  property var fileExist :true

  property var seplines

  property var valCenterCInit : 60
  property var fontListInitNumber : 0
  property var fontListInitName :  "b,#"
  property var fontSizeInit : 13
  property var yPositionInit : 0
  property var xPositionInit : 0
  property var partListInit : 0
  property var colorListInit : 0


  property var fontName: [ "b,#","♭,♯" ]
  property var fontNameSel : 0
// Item positions in menu window
  property var itemX1 : 10
  property var itemX2 : 150
  property var itemY1 : 10
  property var itemDY : 25
  


  RowLayout {  //======================  FONT
    id: row1
    x :itemX1
    y :itemY1+itemDY*0.5
    Label {
//      font.pointSize: fontSizeMenu
      text: "♭♯ Font"
    }
  }

  RowLayout {
    id: row1R
    x :itemX2
    y :itemY1+itemDY*0.5
    ComboBox {
      currentIndex: fontListInitNumber
      model: ListModel {
        id: fontList
        property var key
        ListElement { text: "b,#"; fName: 0 }
        ListElement { text: "♭,♯"; fName: 1 }
//        ListElement { text: "Jianpu"; fName: 4 }
      }
      width: 100
      onCurrentIndexChanged: {
//        console.debug(fontList.get(currentIndex).text + ", " + fontList.get(currentIndex).fName)
        fontList.key = fontList.get(currentIndex).fName
      }
    } // end ComboBox
  }


  RowLayout {  //======================  FONT SIZE
    id: row2
    x :itemX1
    y :itemY1+itemDY*2
    Label {
//      font.pointSize: fontSizeMenu
      text: "Font Size"
    }
  }

  RowLayout {
    id: row2R
    x :itemX2
    y :itemY1+itemDY*2
    SpinBox {
      id: valFontSize
      implicitWidth: 55
      decimals: 0
      minimumValue: 4
      maximumValue: 36
      value: fontSizeInit
//      font.pointSize: fontSizeMenu
    }
  }


  RowLayout {  //======================  Y POSITION
    id: row3
    x :itemX1
    y :itemY1+itemDY*4+10
    Label {
//      font.pointSize: fontSizeMenu
      text: "Y position"
    }
  }

  RowLayout {
    id: row3R
    x :itemX2
    y :itemY1+itemDY*4+7
    SpinBox {
      id: valYPosition
      implicitWidth: 55
      decimals: 0
      minimumValue: -20
      maximumValue: 30
      value: yPositionInit
//      font.pointSize: fontSizeMenu
    }
  }


  
  RowLayout {  //======================  Jampu Notation Middle C MIDI note number
    id: rowJ
    x :itemX1
    y :itemY1+itemDY*3+5
    Label {
//      font.pointSize: fontSizeMenu
      text: "1 starts from(MIDInum)"
    }
  }

  RowLayout {
    id: rowJR
    x :itemX2
    y :itemY1+itemDY*3+5
    SpinBox {
      id: valCenterC
      implicitWidth: 55
      decimals: 0
      minimumValue: 0
      maximumValue: 127
      value: valCenterCInit
//      font.pointSize: fontSizeMenu
    }
  }



  
    
  RowLayout {  //======================  X POSITION
    id: row4
    x :itemX1
    y :itemY1+itemDY*4+40
    Label {
//      font.pointSize: fontSizeMenu
      text: "X position"
    }
  }

  RowLayout {
    id: row4R
    x :itemX2
    y :itemY1+itemDY*4+40
    SpinBox {
      id: valXPosition
      implicitWidth: 55
      decimals: 1
      minimumValue: -5
      maximumValue: 5
      value: xPositionInit
      stepSize: 0.1
//      font.pointSize: fontSizeMenu
    }
  }


  RowLayout {  //======================  PART
    id: row5
    x :itemX1
    y :itemY1+itemDY*5+40
    Label {
//      font.pointSize: fontSizeMenu
      text: "Part"
    }
  }

  RowLayout {
    id: row5R
    x :itemX2
    y :itemY1+itemDY*5+40
    ComboBox {
        currentIndex: partListInit
        model: ListModel {
        id: partList
        property var key
        ListElement { text: "Part 1"; pName: 0 }
        ListElement { text: "Part 2"; pName: 1 }
        ListElement { text: "Part 3"; pName: 2 }
        ListElement { text: "Part 4"; pName: 3 }
      }

      width: 60
      onCurrentIndexChanged: {
//console.debug(partList.get(currentIndex).text + ", " + partList.get(currentIndex).pName)
        partList.key = partList.get(currentIndex).pName
      }
    } // end ComboBox
  }


  RowLayout {  //======================  COLOR
    id: row6
    x :itemX1
    y :itemY1+itemDY*6+40
    Label {
//      font.pointSize: fontSizeMenu
      text: "Color"
    }
  }

  RowLayout {
    id: row6R
    x :itemX2
    y :itemY1+itemDY*6+40
    ComboBox {
      currentIndex: colorListInit
      model: ListModel {
        id: colorList
        property var key
        ListElement { text: "Black"; cName: 0 }
        ListElement { text: "Red"; cName: 1 }
        ListElement { text: "Blue"; cName: 2 }
        ListElement { text: "Green"; cName: 3 }
        ListElement { text: "Purple"; cName: 4 }
        ListElement { text: "Gray"; cName: 5 }
      }
      width: 60
      onCurrentIndexChanged: {
//console.debug(colorList.get(currentIndex).text + ", " + colorList.get(currentIndex).cName)
        colorList.key = colorList.get(currentIndex).cName
      }
    } // end ComboBox
  }

  RowLayout { //============ Ver. No. ================
  id: rowVerNo
    x : 10
    y : 230
    Label {
      font.pointSize: 10
      text: "V"+version
    }
    }

  RowLayout {  //======================  CANCEL  /  OK
    id: row7
    x : 10
    y : 250
    Button {
      id: closeButton
      text: "Cancel"
      onClicked: { quit() }
    }
    Button {
      id: okButton
      text: "Ok"
      onClicked: {
        apply()
        quit()
      }
    }
  }


  function apply() {
    curScore.startCmd()
    applyToSelection()
//    my_file1.write(fontList.key+"\n"+valFontSize.value+"\n"+valYPosition.value+"\n"+valXPosition.value+"\n"+partList.key+"\n"+colorList.key)
    curScore.endCmd()
  }



  onRun: {
//    if( fileExist ) var fileContents = my_file1.read();
//    if( !fileExist ) var fileContents="8\n0\n13\n0\n0\n0\n0\n0";

//    seplines=fileContents.split("\n");
//console.log("seplines="+seplines);
/*
    fontListInitNumber=Number(seplines[0]);
    fontSizeInit=Number(seplines[1]);
    yPositionInit=Number(seplines[2]);
    xPositionInit=Number(seplines[3]);
    partListInit=Number(seplines[4]);
    colorListInit=Number(seplines[5]);
*/
//console.log("on Run : fontListInitName="+fontListInitName);

    if (typeof curScore === 'undefined')
    quit();
  } // end onRun


  function applyToSelection() {

    var cursor = curScore.newCursor();
    var startStaff;
    var endStaff;
    var endTick;
    var fullScore = false;

//    var yPos = valYPosition.value+10 ;   //     Y offset= +10
    var yPos = valYPosition.value;   //     Y offset= 0

    if(fontList.key==0) var xPos = valXPosition.value-0.3;      //  Jianpu b,#
    if(fontList.key==1) var xPos = valXPosition.value-0.3;      //  Jianpu ♭,♯

    var fontSize = valFontSize.value;

//    var fontSizeTag="<font size=\""+fontSize+"\"/>";
    var fontSizeTag="" //<font size=\""+fontSize+"\"/>";
//    var fontSizeSTag="<font size=\""+(fontSize-3)+"\"/>";
    var fontFaceTag="<font face=\""+fontJianpu+"\"/>";

    var selPart=0;
//               RGB color  Black     , Red          , Blue         , Green       , Purple       , Gray
    var colorData=  [ "#000000" ,"#FF0000" ,"#0000FF" ,"#00FF00" ,"#C007C0" ,"#888888" ];
    var fontColor=colorData[colorList.key];
//console.log(fontName);

    cursor.rewind(1);  // rewind to start of selection
    if (!cursor.segment) { // no selection
      fullScore = true;
      startStaff = 0; // start with 1st staff
      endStaff  = curScore.nstaves - 1; // and end with last
    } else {
      startStaff = cursor.staffIdx;
      cursor.rewind(2); // rewind to end of selection
      if (cursor.tick == 0) {
        endTick = curScore.lastSegment.tick + 1;
      } else {
        endTick = cursor.tick;
      }
      endStaff   = cursor.staffIdx;
    }
//console.log("Part: "+partList.key);
//console.log(startStaff + " - " + endStaff + " - " + endTick);


    for (var staff = startStaff; staff <= endStaff; staff++) {
//      for (var voice = 0; voice < 4; voice++) {
        var voice=partList.key;

        cursor.rewind(1); // beginning of selection
        cursor.voice    = voice;
        cursor.staffIdx = staff;


			if (fullScore)  // no selection
          cursor.rewind(0); // beginning of score


        while (cursor.segment && (fullScore || cursor.tick < endTick)) {
         var text = newElement(Element.STAFF_TEXT);

				if (cursor.element && cursor.element.type == Element.CHORD) { // 休符でなく音符の場合
					var text = newElement(Element.STAFF_TEXT);
			text.placement = Placement.BELOW
            text.autoplace = false;  // add 2019.9.18
//          console.log('>>> cursol.key = ' + cursor.keySignature);

//text.offsetX=0
//text.offsetY=0

text.fontSize=fontSize;  // added 2023.6.24

					
// ######################## GRACE #####################################
            var graceChords = cursor.element.graceNotes;
            for (var i = 0; i < graceChords.length; i++) {


              var notes = graceChords[i].notes;
//              nameChord(notes, text, fontList.key, fontSize);
              nameChord(notes, text, fontList.key);

text.fontSize=fontSize*0.7;  // added 2023.6.24

              text.offsetX =xPos -2.0 * (graceChords.length - i);      // X position of Grace note

              switch (voice) {
                case 0: text.offsetY = yPos+6; break;
                case 1: text.offsetY = yPos+2+6; break;
                case 2: text.offsetY = yPos+4+6; break;
                case 3: text.offsetY = yPos+6+6;  break;
              }
              text.color= fontColor;

              text.text= fontSizeTag + fontFaceTag + text.text;
//              if(fontList.key==0)      text.text= fontSizeTag + fontFaceTag + text.text; // b,#
//              else                     text.text= fontSizeTag + fontFaceTag + text.text; // ♭,♯
text.placement = Placement.BELOW
text.autoplace = false;  // add 2019.9.18
			  cursor.add(text);  //  装飾音符に表示
			  text  = newElement(Element.STAFF_TEXT);
			} // end graceChorde


//####################################################################

            var notes = cursor.element.notes;
//            nameChord(notes, text, fontList.key, fontSize);
            nameChord(notes, text, fontList.key);

            switch (voice) {
              case 0: text.offsetY = yPos+6; break;
              case 1: text.offsetY = yPos+2+6; break;
              case 2: text.offsetY = yPos+4+6; break;
              case 3: text.offsetY = yPos+6+6; break;
            }
            text.color= fontColor;
            text.offsetX= xPos;

//            console.log("before "+text.text)
//                            text.text= fontSizeTag + fontFaceTag + text.text;
//            console.log("after    "+text.text)
//              if(fontList.key==0)      text.text= fontSizeTag + fontFaceTag + text.text; // b#
//              else                     text.text= fontSizeTag + fontFaceTag + text.text; // ♭♯

text.fontSize=fontSize;  // added 2023.6.25

text.placement = Placement.BELOW; // added 2023.6.25
text.autoplace = false;           // added 2023.6.25
				cursor.add(text); //   音符に表示


			} else{ //  if (cursor.isRest)  { // if ( cursor.isRest() ){   //  休符に"0"を表示する。
//          console.log(cursor.isRest);
            switch (voice) {
              case 0: text.offsetY = yPos+10; break;
              case 1: text.offsetY = yPos+2+10; break;
              case 2: text.offsetY = yPos+4+10; break;
              case 3: text.offsetY = yPos+6+10; break;
            }
            text.color= fontColor;
            text.offsetX= xPos;

            text.text= fontSizeTag + fontFaceTag+qsTr("0"); // ゼロを表示

            text.offsetY = -yPos;   //ゼロのY    2020.1.17
            text.offsetX = -xPos;   //ゼロのX    2020.1.17

text.fontSize=fontSize;  // added 2023.6.24

		if(cursor.voice == voice) cursor.add(text); //   音符に表示 

text.autoplace = false;  // add 2019.9.18
text.offsetY = yPos+6+4;      //           "+6"      add 2020.1.27 , "+4" add 2020.9.17
text.offsetX= xPos;

			} // end if CHORD  and ゼロ文字
          cursor.next();
        } // end while segment
//      } // end for voice
    } // end for staff
   quit();
  } // end onRun



//  function nameChord (notes, text, fontListNo, fontSize) {
function nameChord (notes, text, fontListNo) {
    var fingerings = [ "A", "B",  // Otsu RO Omeri, Otsu RO meri
      "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",  // Otsu
      "P", "Q", "R", "S", "T", "U", "V", "W", "X","Y", "Z", "a",        // Kan
      "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n"]  // Daikan
//     var noteNameS = [ "C","C#","D","D#","E","F","F#","G","G#","A","A#","B" ]
//     var noteNameF = [ "C","Db","D","Eb","E","F","Gb","G","Ab","A","Bb","B" ]
     var noteNameS = [ "C","C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B" ]
     var noteNameF = [ "C","D♭","D","E♭","E","F","G♭","G","A♭","A","B♭","B" ]
     if(fontListNo==0){
       var JampuS= ["1","#1","2","#2","3","4","#4","5","#5","6","#6","7"]
       var JampuF= ["1","b2","2","b3","3","4","b5","5","b6","6","b7","7"]
     } else {
       var JampuS= ["1","♯1","2","♯2","3","4","♯4","5","♯5","6","♯6","7"]
       var JampuF= ["1","♭2","2","♭3","3","4","♭5","5","♭6","6","♭7","7"]
     }

//    var fontSizeTag="<font size=\""+fontSize+"\"/>";
    var fontSizeTag="" //<font size=\""+fontSize+"\"/>";
//    var fontSizeSTag="<font size=\""+(fontSize-3)+"\"/>";
    var fontSizeSTag="" //<font size=\""+(fontSize-3)+"\"/>";
    var fontFaceTag="<font face=\""+fontJianpu+"\"/>";

    var pitchFing;
    for (var i = 0; i < notes.length; i++) {  // 和音の場合のループ
      var sep = "\n";   //  ","; // change to "\n" if you want them vertically

      if ( i > 0 ) text.text = sep + text.text; // 単音でないときは改行コードを先頭に追加する


	  if(pitchFing<0 || pitchFing>=fingerings.length)  // out of range
        text.text=" "+text.text;
      else{
        if(notes[i].tieBack == null) {  // タイの後ろ側ではないとき===================================
        text.text=text.text;

//     #.:1 というように、点は#,bの間に入れる必要がある
// 82, 84のときcenter=58,とすると pitchShift=-2なので  84,86  , ２つ先の運指となる
          var pitchShift=valCenterC.value-60;
          var pitchIndex1=parseInt( (notes[i].pitch -pitchShift)/12 )-5; // オクターブ 84/12=7, 7-5=2
//          console.log("notes[i].pitch -pitchShift  ",notes[i].pitch -pitchShift);
//         console.log("(notes[i].pitch -pitchShift)/12  ",(notes[i].pitch -pitchShift)/12);
//          console.log("parseInt(notes[i].pitch -pitchShift)/12)  ",parseInt((notes[i].pitch -pitchShift)/12)-5);
          var pitchIndex2=parseInt( (notes[i].pitch-pitchShift) % 12) ;    //  オクターブ内の音程 0-11
          var After="";
          var Before="";
          if(pitchIndex1==-5) After="::.";
          if(pitchIndex1==-4) After="::";
          if(pitchIndex1==-3) After=":.";
          if(pitchIndex1==-2) After=":";
          if(pitchIndex1==-1) After=".";
          if(pitchIndex1==0) After="";
          if(pitchIndex1==0) Before="";
          if(pitchIndex1==1) Before=".";
          if(pitchIndex1==2) Before=":";
          if(pitchIndex1==3) Before=".:";
          if(pitchIndex1==4) Before="::";
          if(pitchIndex1==5) Before=".::";

//          console.log("pitch[i]=",i," ",notes[i].pitch);
//console.log(" pitchIndex1=",pitchIndex1," After=",After," Before=",Before);
//console.log(" pitchIndex2=",pitchIndex2," After=",After," Before=",Before);
//console.log("notes[i].tpc,i =",notes[i].tpc, i);
//ここから
            if(notes[i].tpc>=6 && notes[i].tpc<=12 && JampuF[pitchIndex2].length==2 ) { //  b  Flatの場合 20200917
//    console.log("JampuF[pitchIndex2].length =",JampuF[pitchIndex2].length);
            if(fontListNo==0)        text.text= fontSizeTag   + fontFaceTag +qsTr(JampuF[pitchIndex2].substr(0,1)+                     Before+qsTr(JampuF[pitchIndex2].substr(1))+After) +text.text ; // b
            else if(fontListNo==1) text.text= fontSizeSTag + fontFaceTag +qsTr(JampuF[pitchIndex2].substr(0,1)+ fontSizeTag+Before+JampuF[pitchIndex2].substr(1)+After) +text.text ; // ♭
//console.log("flat ",text.text);
          } else if ( notes[i].tpc>=20 && notes[i].tpc<=26 && JampuF[pitchIndex2].length==2 ){   //  #  Sharpの場合 20200917
                if(fontListNo==0)        text.text= fontSizeTag   + fontFaceTag +qsTr(JampuS[pitchIndex2].substr(0,1)+                     Before+JampuS[pitchIndex2].substr(1)+After) +text.text ; // #
                else if(fontListNo==1) text.text= fontSizeSTag + fontFaceTag +qsTr(JampuS[pitchIndex2].substr(0,1)+ fontSizeTag+Before+JampuS[pitchIndex2].substr(1)+After) +text.text ; // ♯
//console.log("sharp ",text.text);
          } else{ // b#でない場合
// ここまでがおかしい
//                        text.text= fontSizeTag + fontFaceTag +qsTr(Before+JampuS[pitchIndex2]+After) +text.text ;
                        text.text= fontFaceTag +qsTr(Before+JampuS[pitchIndex2]+After) +text.text ; // 2023.6.25
//console.log("natural ",text.text);
          }

//        }
        }
      } // end for tieBack
    } // end for note
  } // end function


//  FileIO {
//    id: my_file1
//    source: tempPath() + "/temp9999sb.txt"
//    source: "/Users/tac/Documents/temp9999sb.txt"
//    onError: fileExist=false // console.log(msg)
//  }
} // end MuseScore
