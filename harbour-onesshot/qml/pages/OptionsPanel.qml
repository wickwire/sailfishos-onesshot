/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property int countHosts
    property int countProfiles

    DBFunctions{ id: dbFunction}

    SilicaListView {
        id: listView
        model: 1
        anchors.fill: parent
        header: PageHeader {
            title: "Manage Profiles"
        }
        delegate: BackgroundItem {
            id: delegate


            Component.onCompleted: {
                dbFunction.profileCount()
                dbFunction.hostCount()
            }

            Dialog {

                id: emptyHostList

                Text{
                    width: parent.width
                    text: "Host List is empty, please add a Host"
                    color: "white"
                    y: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    pageStack.clear()
                    pageStack.push("OptionsPanel.qml")
                }
            }

            Dialog {

                id: emptyProfileList

                Text{
                    width: parent.width
                    text: "Profiles List is empty, please add a Profile"
                    color: "white"
                    y: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    pageStack.clear()
                    pageStack.push("OptionsPanel.qml")
                }
            }

            Button{
                id: hostCreate
                text: "Add Host"
                onClicked: pageStack.push("HostCreate.qml")
                y: height*1.5*1
            }

            Button{
                id: hostDelete
                text: "Remove Host"
                onClicked: {
                    if(countHosts > 0){
                        pageStack.push("HostDelete.qml")
                    }
                    else{
                        pageStack.push(emptyHostList)
                        console.log("Empty Host List: " + countHosts)
                    }
                }
                y: height*1.5*2
            }

            Button{                
                id: profileCreate
                text: "Add Profile"
                onClicked: {
                    if(countHosts > 0){
                        pageStack.push("ProfileCreate.qml")
                    }
                    else{
                        pageStack.push(emptyHostList)
                        console.log("Empty Host List: " + countHosts)
                    }
                }

                y: height*1.5*3
            }

            Button{
                id: profileDelete
                text: "Remove Profile"
                onClicked: {
                    if(countProfiles > 0){
                        pageStack.push("ProfileDelete.qml")
                    }
                    else{
                        pageStack.push(emptyProfileList)
                        console.log("Empty Profile List" + countProfiles)
                    }
                }
                y: height*1.5*4
            }

            Button{
                id: dbDrop
                text: "Clear Database"
                onClicked: pageStack.push("DropDB.qml")
                y: height*1.5*5
            }
        }
    }
}





