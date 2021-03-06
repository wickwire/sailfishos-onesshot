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

    property string sshUser
    property string sshHost
    property string sshAddress
    property int sshPort
    property string sshCommand

    DBFunctions{ id: dbFunction }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {

            MenuItem {
                text: "Manage Profiles"
                onClicked: pageStack.push("OptionsPanel.qml")
            }
            MenuItem {
                text: "Manage SSH Keys"
                onClicked: pageStack.push("ManageSSHKeys.qml")
            }
            MenuItem {
                text: "Help/About"
                onClicked: pageStack.push("AboutPage.qml")
            }
        }


        ListModel{
            id: profileModel


            Component.onCompleted: {
                dbFunction.listProfiles()
            }
        }

        SilicaListView {

            id: listView
            model: profileModel
            anchors.fill: parent
            header: PageHeader {
                title: "Profile List"
            }
            delegate: BackgroundItem {
                id: delegate

                Label {
                    x: Theme.paddingLarge
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                onClicked: {
                    console.log("hostId: " + hostId + "profileId: " + profileId)
                    dbFunction.getTheMark(hostId,profileId)
                    sshCmd.executeSSH(sshUser,sshAddress,sshPort,sshCommand)

                    var dialog = pageStack.push(sshot)


                }

                onPressAndHold: {
                    console.log("HomeScreen Long Press: " + profileId + "|" + name + "|" + hostId + "|" + command);

                    var selectedProfile = {
                        "activeProfileId" : profileId,
                        "activeProfile" : name,
                        "activeHostId" : hostId,
                        "activeCommand" : command
                    };
                    pageStack.push("ProfileUpdate.qml",selectedProfile)
                }
            }

            Dialog {

                id: sshot

                Text{
                    width: parent.width
                    text: "SSHot fired successfully!"
                    color: "white"
                    y: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    pageStack.clear()
                    pageStack.push("HomeScreen.qml")
                }
            }


            VerticalScrollDecorator {}
        }
    }
}
