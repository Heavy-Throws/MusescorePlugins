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
            nav_cursor.cursor.rewind(0);
            nav_cursor.cursor.next();
            updateCursorPos();
      }
      
      function updateCursorPos() {
            text5.text = nav_cursor.cursor.tick;
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
                  //todo: output something here.
                  text: "Score"
                  enabled: false
                  onClicked: {
                        text1.text = "Score";
                        text3.text = nav_cursor.cursor.score;
                  }
            }
            Button {
                  text: "Track"
                  onClicked: {
                        text1.text = "Track";
                        text3.text = nav_cursor.cursor.track;
                  }
            }
            Button {
                  //todo:handle undefined
                  text: "StaffIdx"
                  enabled: false
                  onClicked: {
                        text1.text = "Track";
                        text3.text = nav_cursor.cursor.staffidx;
                  }
            }
            Button {
                  text: "Voice"
                  onClicked: {
                        text1.text = "Voice";
                        text3.text = nav_cursor.cursor.voice;
                  }
            }            
            Button {
                  text: "Filter"
                  onClicked: {
                        text1.text = "Filter";
                        text3.text = nav_cursor.cursor.filter;
                  }
            }
            Button {
                  //todo:Make output make more sense
                  text: "InputState"
                  enabled: false
                  onClicked: {
                        text1.text = "InState";
                        text3.text = nav_cursor.cursor.inputStateMode;
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
                        text1.text = "Refresh Data";
                        text5.text = nav_cursor.cursor.tick;
                  }
            }                    
      }
      ColumnLayout{
            Layout.alignment:Qt.AlignTop
            Button {
                  //todo: output something
                  text: "Element"
                  enabled: false
                  onClicked: {
                        text1.text = "Element";
                        text3.text = nav_cursor.cursor.element;
                  }
            }
            Button {
                  //todo: undefined, and output something
                  text: "QMLSegment"
                  enabled: false
                  onClicked: {
                        text1.text = "QMLSement";
                        text3.text = nav_cursor.cursor.qmlSegment;
                  }
            }            
            Button {
                  //todo: output something
                  text: "Measure"
                  enabled: false
                  onClicked: {
                        text1.text = "Measure";
                        text3.text = nav_cursor.cursor.measure;
                  }
            }
            Button {
                  text: "Tick"
                  onClicked: {
                        text1.text = "Tick";
                        text3.text = nav_cursor.cursor.tick;
                  }
            }              
            Button {
                  text: "Time"
                  onClicked: {
                        text1.text = "Time";
                        text3.text = nav_cursor.cursor.time;
                  }
            }              
            Button {
                  text: "Tempo"
                  onClicked: {
                        text1.text = "Tempo";
                        text3.text = nav_cursor.cursor.tempo;
                  }
            }              
            Button {
                  //todo: undefined
                  text: "TimeSig"
                  enabled: false
                  onClicked: {
                        text1.text = "TimeSig";
                        text3.text = nav_cursor.cursor.qmlKeySignature;
                  }
            }  
            Button {
                  text: "Input Sync"
                  onClicked: {
                        text1.text = "Input Synced";
                        nav_cursor.cursor.inputStateMode = "INPUT_STATE_SYNC_WITH_SCORE";
                        text3.text = nav_cursor.cursor.inputStateMode;
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
                        text3.text = nav_cursor.cursor.inputStateMode;
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
            text: "Last Cmd"
      }
      Text{
            id: text2Title
            text: "Cursor Valid?"
      }
      Text{
            id: text3Title
            text: "Data Point"
      }
      Text{
            id: text5Title
            text: "Cursor Loc"
      }      
      Text{
            id: text4Title
            text: "Errors"
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
            id: text3
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
      }
      }
      }
}
