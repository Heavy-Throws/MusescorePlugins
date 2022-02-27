import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MuseScore 3.0

MuseScore {
      menuPath: "Plugins.Cursor Explorer"
      description: "Use this plugin to help understand cursors."
      version: "0.1"
      pluginType: "dock"
      dockArea: "right"
      implicitWidth:  250
      
      property var cursor: curScore.newCursor();

      onScoreStateChanged: {
            textLastCmd.text = "User Selection";
            updateCursorPos();
      }
      
      onRun: {
            console.log("Starting Cursor Explorer");
            cursor.inputStateMode = "INPUT_STATE_SYNC_WITH_SCORE";
            updateCursorPos();
      }
      
      function updateCursorPos() {
            textTick.text = cursor.tick;
            textString.text = cursor.stringNumber;
            if(cursor.inputStateMode === 0)
                  textSync.text = "Independant"
            else
                  textSync.text = "Synced"
            textTempo.text = cursor.tempo;
            textTime.text = cursor.time;
            textTrack.text = cursor.track;
            textVoice.text = cursor.voice;
            textFilter.text = cursor.filter;
            textTimeSig.text = cursor.keySignature;
            textScore.text = cursor.score.scoreName;
            textStaff.text = cursor.staffIdx;

            //Check if anything is selected, end if nothing.
            if(!cursor.element){
                textSelType.text = "";
                textNotes.text = "";
                textGraces.text = "";
                textSegment.text = "";
                textMeasure.text = "";
                textValid.text = "Invalid";
                return false;
            }

            //Describe selection
            switch (cursor.element.name){
                case "Rest":
                    textSelType.text = cursor.element.name;
                    textNotes.text = "";
                    textGraces.text = "";
                    textSegment.text = cursor.segment.name;
                    textMeasure.text = cursor.measure.name;
                    break;
                case "Chord":
                    textSelType.text = cursor.element.name;
                    textNotes.text = cursor.element.notes.length;
                    textGraces.text = cursor.element.graceNotes.length;
                    textSegment.text = cursor.segment.name;
                    textMeasure.text = cursor.measure.name;
                    break;
                default:
                    textSelType.text = "";
                    textNotes.text = "";
                    textGraces.text = "";
                    textSegment.text = "";
                    textMeasure.text = "";
            }
      }

      
      ColumnLayout{
      RowLayout{  
      ColumnLayout{
            Layout.alignment:Qt.AlignTop
            Button {
                  text: "Prev"
                  onClicked: {
                        textLastCmd.text = "Prev";
                        if(cursor.prev())
                              textValid.text = "Valid";
                        else
                              textValid.text = "Invalid";
                        updateCursorPos();
                  }
            }
            Button {
                  text: "Input Sync"
                  onClicked: {
                        textLastCmd.text = "Input Synced";
                        cursor.inputStateMode = "INPUT_STATE_SYNC_WITH_SCORE";
                        updateCursorPos(); 
                  }
            } 
            Button {
                  text: "Rewind Start"
                  onClicked: {
                        textLastCmd.text = "Rewind to start";
                        cursor.rewind(0);
                  }
            } 
            Button {
                  text: "Rwd Tick"
                  onClicked: {
                        textLastCmd.text = "Rewind to Tick";
                        cursor.rewindToTick(tickText.text);
                  }
            }   
            TextInput {
                  id: tickText
                  text: "240"
                  inputMethodHints: Qt.ImhDigitsOnly;
            } 

            Button {
                  text: "Add *"
                  onClicked: {
                        var el = cursor.element;
                        textLastCmd.text = "Add *";
                        var chord = newElement(Element.CHORD);
                        chord.track = cursor.track;
                        //chord.type = GRACE32;
                        var note = newElement(Element.NOTE);
                        note.pitch = 79;
                        //note.type = GRACE32;
                        //chord.add(note);
                        //cursor.add(chord);
                        //cursor.add(a);
                        //cursor.rewindToTick(tickText.text);
                  }
            }  
      }    
      ColumnLayout{
            Layout.alignment:Qt.AlignTop
            Button {
                  text: "Next"
                  onClicked: {
                        textLastCmd.text = "Next";
                        if(cursor.next())
                              textValid.text = "Valid";
                        else
                              textValid.text = "Invalid";
                        updateCursorPos();
                  }
            }
            Button {
                  text: "Input Ind"
                  onClicked: {
                        textLastCmd.text = "Input Independant";
                        cursor.inputStateMode = "INPUT_STATE_INDEPENDENT";
                        updateCursorPos();
                  }
            } 
            Button {
                  text: "Rwd Sel Start"
                  onClicked: {
                        textLastCmd.text = "Rewind to selection start";
                        cursor.rewind(1);
                  }
            }  


            Button {
                  text: "Add Rest"
                  onClicked: {
                        textLastCmd.text = "Add rest";
                        cursor.addRest();
                  }
            }                    
      }
      ColumnLayout{
            Layout.alignment:Qt.AlignTop   
            Button {
                  text: "NextMeas"
                  onClicked: {
                        textLastCmd.text = "Next Measure";
                        if(cursor.nextMeasure())
                              textValid.text = "Valid";
                        else
                              textValid.text = "Invalid";
                  }
            }   
            Button {
                  text: "Refresh"
                  onClicked: {
                        console.log("REFRESH");
                        textLastCmd.text = "Refresh Data";
                        updateCursorPos();
                  }
            } 
            Button {
                  text: "Rwd Sel End"
                  onClicked: {
                        textLastCmd.text = "Rewind to selection end";
                        cursor.rewind(2);
                  }
            }                                            
 
 
            Button {
                  text: "Add Note"
                  onClicked: {
                        textLastCmd.text = "Add Note";
                        cursor.track = 0;
                        cursor.setDuration(1,8);
                        cursor.addNote(73);
                  }
            }
            Button {
                  text: "Add Tuplet"
                  enabled: false
                  onClicked: {
                        textLastCmd.text = "Add Tuplet";
                        //cursor.rewindToTick(tickText.text);
                  }
            }  
            Button {
                  text: "Set dur"
                  enabled: false
                  onClicked: {
                        textLastCmd.text = "Set Duration";
                        //cursor.rewindToTick(tickText.text);
                  }
            }             
      }
      }
      RowLayout{
      ColumnLayout{
      Text{
            id: textSyncTitle
            text: "Sync Mode"
      }
      Text{
            id: textLastCmdTitle
            text: "Last Request"
      }
      Text{
            id: textValidTitle
            text: "Cursor Valid?"
      }
      Text{
            id: selTypeTitle
            text: "Sel Type"
      }
      Text{
            id: textLoc
            text: "Cursor Loc"
      }      
      Text{
            id: textError
            text: "Errors"
      }
      Text{
            id:titleTempo
            text: "Tempo"
      }
      Text{
            id:titleTime
            text: "Time"
      }
      Text{
            id: titleTrack
            text: "Track"
      }
      Text{
            id:titleVoice
            text: "Voice"
      }
      Text{
            id:titleFilter
            text: "Filter"
      }   
      Text{
            id:titleScore
            text: "Score"
      }
      Text{
            id:titleStaff
            text: "Staff"
      }  
      Text{
            id:titleMeasure
            text: "Measure"
      }  
      Text{
            id:titleSegment
            text: "Segment"
      }    
      Text{
            id:titleTimeSig
            text: "Key Sig"
      }    
      Text{
            id:titleGraces
            text: "Gracenotes"
      }    
      Text{
            id:titleNotes
            text: "Notes"
      } 
      Text{
            id:titleString
            text: "String Num"
      }    
      }
      ColumnLayout{
      Text{
            id: textSync
            text: "Independant"
      }
      Text{
            id: textLastCmd
            text: ""
      }
      Text{
            id: textValid
            text: "Valid"
      }
      Text{
            id: textSelType
            text: ""
      }
      Text{
            id: textTick
            text: ""
      }  
      Text{
            id: text4
            text: "."
      } 
      Text{
            id: textTempo
            text: ""
      }   
      Text{
            id: textTime
            text: ""
      } 
      Text{
            id: textTrack
            text: ""
      }   
      Text{
            id: textVoice
            text: ""
      } 
      Text{
            id: textFilter
            text: ""
      }
      Text{
            id: textScore
            text: ""
      } 
      Text{
            id: textStaff
            text: ""
      }  
      Text{
            id: textMeasure
            text: ""
      }  
      Text{
            id: textSegment
            text: ""
      }  
      Text{
            id: textTimeSig
            text: ""
      }
      Text{
            id: textGraces
            text: ""
      }  
      Text{
            id: textNotes
            text: ""
      }
      Text{
            id:textString
            text: ""
      }
      }
      }
      }
}
