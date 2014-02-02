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
    property int profileHostId
    property string profileHost
    property string profileCommand

    property int activeProfileId
    property string activeProfile
    property string activeHost
    property int activeHostId
    property string activeCommand


    ListModel{
        id: hostModel

        Component.onCompleted: {
            dbFunction.listHosts()
        }
    }

    SilicaListView {
        id: listView
        model: 1
        anchors.fill: parent
        header: PageHeader {
            title: "Update Profile"
        }
        delegate: BackgroundItem {
            id: delegate
            height: 400

            TextField {
                id: profileNameField
                //placeholderText: "Profile Name"
                text: activeProfile
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
            }

            TextField {
                id: profileCommandField
                text: activeCommand
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
                currentIndex: activeHostId

                menu: ContextMenu {
                    id: contextMenu

                    Repeater {

                    model: hostModel

                    MenuItem { text: name

                        Component.onCompleted: profileHostId = hostId;

                    }

                    }

                }
            }

            Button{
                id: profileSave
                text: "Save Profile"
                y: profileHostField.y+profileHostField.height

                onClicked: {
                    profileId=activeProfileId
                    profileName=profileNameField.text
                    //profileHostId=profileHostField.currentItem.objectName.
                    profileHost=profileHostField.currentItem.text
                    profileCommand=profileCommandField.text

                    console.log("ProfileUpdate - activeProfile: " + activeProfile)

                    console.log("ProfileUpdate - activeID: " + profileId + "profileName: " + profileName + "profileHost: " + profileHost + "profileCommand: " + profileCommand)

                    dbFunction.updateProfile()

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
