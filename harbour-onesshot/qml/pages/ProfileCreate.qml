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

    DBFunctions{ id: dbFunction}

    property int profileId
    property string profileName
    property string profileHost
    property int profileHostId
    property string profileCommand

    SilicaListView {
        id: listView
        model: 1
        anchors.fill: parent
        header: PageHeader {
            title: "Add Profile"
        }
        delegate: BackgroundItem {
            id: delegate
            height: 400

            TextField {
                id: profileNameField
                placeholderText: "Profile Name"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
            }

            TextField {
                id: profileCommandField
                placeholderText: "Command"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: profileNameField.y+profileNameField.height
            }

            ComboBox {
                id: profileHostField
                width: parent.width
                label: "Host"
                y: profileCommandField.y+profileCommandField.height
                height: 100

                menu: ContextMenu {
                    id: contextMenu
                    MenuItem { text: "host1" }
                    MenuItem { text: "host2" }
                    MenuItem { text: "host3" }
                    MenuItem { text: "host4" }
                    MenuItem { text: "host5" }
                    MenuItem { text: "host6" }
                    MenuItem { text: "host7" }
                    MenuItem { text: "host8" }
                    MenuItem { text: "host9" }
                    MenuItem { text: "host10" }
                    MenuItem { text: "host11" }
                    MenuItem { text: "host12" }
                    MenuItem { text: "host13" }
                    MenuItem { text: "host14" }
                    MenuItem { text: "host15" }
                }
            }

            Button{
                id: profileSave
                text: "Save Profile"
                y: profileHostField.y+profileHostField.height

                onClicked: {
                    profileName=profileNameField.text
                    profileHostId=profileHostField.currentIndex
                    profileHost=profileHostField.currentItem.text
                    profileCommand=profileCommandField.text

                    console.log("profileName: " + profileName + "profileHostId: " + profileHostId + "profileHost: " + profileHost + "profileCommand: " + profileCommand)

                    dbFunction.saveProfile()
                    var dialog = pageStack.push(savedOK)
                }
            }


            Dialog {

                id: savedOK

                Text{
                    width: parent.width
                    text: "Profile saved Successfully!"
                    color: "white"
                    y: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    pageStack.clear()
                    pageStack.push("HomeScreen.qml")
                }
            }
        }
        VerticalScrollDecorator {}
    }
}




