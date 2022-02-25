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
      
      onScoreStateChanged: {
            updateCursorPos();
      }
      
      onRun: {
            console.log("Starting Bagpipe Plugin");
            nav_cursor.cursor.inputStateMode = "INPUT_STATE_SYNC_WITH_SCORE";
            updateCursorPos();
      }
      
      function updateCursorPos() {
            text5.text = nav_cursor.cursor.tick;
            textString.text = nav_cursor.cursor.stringNumber;
            if(nav_cursor.cursor.inputStateMode == 0)
                  text0.text = "Independant" 
            else
                  text0.text = "Synced"  
            textTempo.text = nav_cursor.cursor.tempo;
            textTime.text = nav_cursor.cursor.time;
            textTrack.text = nav_cursor.cursor.track;
            textVoice.text = nav_cursor.cursor.voice;
            textFilter.text = nav_cursor.cursor.filter;
            if(nav_cursor.cursor.element){
                  textSelType.text = nav_cursor.cursor.element.name;
                  try{
                        textNotes.text = nav_cursor.cursor.element.notes.length;
                  }catch(error){
                        textNotes.text = "Error";
                        console.log(nav_cursor.cursor.element.type);
                        console.log(nav_cursor.cursor.element.name);
                  }
                  try{
                        textGraces.text = nav_cursor.cursor.element.graceNotes.length;
                  }catch (error){
                        textGraces.text = "00"
                        console.log("Error getting gracenotes");
                  }
            
                  try
                  {
                        textScore.text = nav_cursor.cursor.score.scoreName;
                  } catch (error) {
                        textScore.text = "None";
                        console.log("Error getting Score: ", nav_cursor.cursor.score);
                  }

                  try
                  {textStaff.text = nav_cursor.cursor.staffIdx;
                  } catch (error) {
                        textStaff.text = "None";
                        console.log("Error getting Staff Index: ", nav_cursor.cursor.staffidx);
                  }
                  
                  try
                  {textSegment.text = nav_cursor.cursor.segment.name;
                  } catch (error) {
                        textSegment.text = "None";
                        console.log("Error getting Segment: ",nav_cursor.cursor.segment);
                  }
            
                  try
                  {textMeasure.text = nav_cursor.cursor.measure.name;
                  } catch (error) {
                        textMeasure.text = "None";
                        console.log("Error getting measure: ", nav_cursor.cursor.measure);
                  }
            
               
                  try
                  {textTimeSig.text = nav_cursor.cursor.keySignature;
                  } catch (error) {
                        textTimeSig.text = "None";
                        console.log("Error getting Key Sig:", nav_cursor.cursor.keySignature);
                  }
            }
      }
      
      QtObject {
            id: nav_cursor;
            property var cursor: curScore.newCursor();     
      }
      ColumnLayout{
      RowLayout{      
      ColumnLayout{
            Layout.alignment:Qt.AlignTop
            Button {
                  text: "Prev"
                  onClicked: {
                        text1.text = "Prev";
                        if(nav_cursor.cursor.prev())
                              text2.text = "Valid";
                        else
                              text2.text = "Invalid";
                        updateCursorPos();
                  }
            }
            Button {
                  text: "Next"
                  onClicked: {
                        text1.text = "Next";
                        if(nav_cursor.cursor.next())
                              text2.text = "Valid";
                        else
                              text2.text = "Invalid";
                        updateCursorPos();
                  }
            }
            Button {
                  text: "NextMeas"
                  onClicked: {
                        text1.text = "Next Measure";
                        if(nav_cursor.cursor.nextMeasure())
                              text2.text = "Valid";
                        else
                              text2.text = "Invalid";
                  }
            }            
            Button {
                  text: "Rwd Sel Start"
                  onClicked: {
                        text1.text = "Rewind to selection start";
                        nav_cursor.cursor.rewind(1);
                  }
            }  
            Button {
                  text: "Rewind Start"
                  onClicked: {
                        text1.text = "Rewind to start";
                        nav_cursor.cursor.rewind(0);
                  }
            } 
            Button {
                  text: "Refresh"
                  onClicked: {
                        console.log("REFRESH");
                        text1.text = "Refresh Data";
                        updateCursorPos();
                  }
            } 
            Button {
                  text: "Add Rest"
                  onClicked: {
                        text1.text = "Add rest";
                        nav_cursor.cursor.addRest();
                  }
            }                    
      }
      ColumnLayout{
            Layout.alignment:Qt.AlignTop                                   
            Button {
                  text: "Input Sync"
                  onClicked: {
                        text1.text = "Input Synced";
                        nav_cursor.cursor.inputStateMode = "INPUT_STATE_SYNC_WITH_SCORE";
                        if(nav_cursor.cursor.inputStateMode == 0)
                              text0.text = "Independant" 
                        else
                              text0.text = "Synced"   
                  }
            }              
            Button {
                  text: "Input Ind"
                  onClicked: {
                        text1.text = "Input Independant";
                        nav_cursor.cursor.inputStateMode = "INPUT_STATE_INDEPENDENT";
                        if(nav_cursor.cursor.inputStateMode == 0)
                              text0.text = "Independant" 
                        else
                              text0.text = "Synced"
                  }
            } 
            Button {
                  text: "Rwd Sel End"
                  onClicked: {
                        text1.text = "Rewind to selection end";
                        nav_cursor.cursor.rewind(2);
                  }
            } 
            Button {
                  text: "Rwd Tick"
                  onClicked: {
                        text1.text = "Rewind to Tick";
                        nav_cursor.cursor.rewindToTick(tickText.text);
                  }
            }   
            TextInput {
                  id: tickText
                  text: "240"
                  inputMethodHints: Qt.ImhDigitsOnly;
            }  
            Button {
                  text: "Add *"
                  enabled: false
                  onClicked: {
                        text1.text = "Add *";
                        //nav_cursor.cursor.rewindToTick(tickText.text);
                  }
            }  
            Button {
                  text: "Add Note"
                  enabled: false
                  onClicked: {
                        text1.text = "Add Note";
                        //nav_cursor.cursor.rewindToTick(tickText.text);
                  }
            }
            Button {
                  text: "Add Tuplet"
                  enabled: false
                  onClicked: {
                        text1.text = "Add Tuplet";
                        //nav_cursor.cursor.rewindToTick(tickText.text);
                  }
            }  
            Button {
                  text: "Set dur"
                  enabled: false
                  onClicked: {
                        text1.text = "Set Duration";
                        //nav_cursor.cursor.rewindToTick(tickText.text);
                  }
            }             
      }
      }
      RowLayout{
      ColumnLayout{
      Text{
            id: text0Title
            text: "Sync Mode"
      }
      Text{
            id: text1Title
            text: "Last Request"
      }
      Text{
            id: text2Title
            text: "Cursor Valid?"
      }
      Text{
            id: selTypeTitle
            text: "Sel Type"
      }
      Text{
            id: text5Title
            text: "Cursor Loc"
      }      
      Text{
            id: text4Title
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
            id: text0
            text: "Independant"
      }
      Text{
            id: text1
            text: ""
      }
      Text{
            id: text2
            text: "Valid"
      }
      Text{
            id: textSelType
            text: ""
      }
      Text{
            id: text5
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
