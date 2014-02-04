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
    property int sshPort
    property string sshCommand

    DBFunctions{ id: dbFunction }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "SSH Public Key"
                onClicked: pageStack.push("GetSSHKey.qml")
            }
            MenuItem {
                text: "Add New Host"
                onClicked: pageStack.push("HostCreate.qml")
            }
            MenuItem {
                text: "Delete Hosts"
                onClicked: pageStack.push("HostDelete.qml")
            }
            MenuItem {
                text: "Add New Profile"
                onClicked: pageStack.push("ProfileCreate.qml")
            }
            MenuItem {
                text: "Delete Profiles"
                onClicked: pageStack.push("ProfileDelete.qml")
            }
            MenuItem {
                text: "Clear DB"
                onClicked: {
                    var dialog = pageStack.push("DropDB.qml")
                }
            }
            MenuItem {
                text: "About"
                onClicked: pageStack.push("AboutPage.qml")
            }
        }

        // Tell SilicaFlickable the height of its content.
        //contentHeight: column.height

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
                    //console.log("checking: " + username + host + port + command);
                    //sshCmd.executeSSH("wickwire", "192.168.55.100", "22", "echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt")
                    dbFunction.getTheMark(hostId)
                    sshCmd.executeSSH(sshUser,sshHost,sshPort,sshCommand)
                    //sshCmd.executeSSH(username, host, port, command)
                    //console.log("getTheMark: " + hostUser + "|" + hostName + "|" + hostPort + "|" + profileCommand)
                }

                onPressAndHold: {
                    console.log("HomeScreen Long Press: " + profileId + "|" + name + "|" + hostId + "|" + host + "|" + command);

                    var selectedProfile = {
                        "activeProfileId" : profileId,
                        "activeProfile" : name,
                        "activeHostId" : hostId,
                        "activeHost" : host,
                        "activeCommand" : command
                    };
                    pageStack.push("ProfileUpdate.qml",selectedProfile)
                }
            }
            VerticalScrollDecorator {}
        }
    }
}
