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
import QtQuick.LocalStorage 2.0


Page {
    id: page


    property var db: null
    property var rs: null
    property string profileName: null
    property string profileHost: null
    property string profilePort: null
    property string profileUsername: null
    property string profilePassword: null
    property string profileCommand: null

    function saveProfile() {

        if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                //tx.executeSql('DROP TABLE oneSSHot;');

                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHot( profileName TEXT, profileHost TEXT, profilePort TEXT,profileUser TEXT,profilePass TEXT, profileCommand TEXT);');

                // Add (another) profile row
                tx.executeSql('INSERT INTO oneSSHot VALUES(?, ?, ?, ?, ?, ?);', [profileName, profileHost, profilePort, profileUsername, profilePassword, profileCommand]);

                rs = tx.executeSql('SELECT * FROM oneSSHot;');

                for(var i = 0; i < rs.rows.length; i++) {
                    console.log(rs.rows.item(i).profileName
                                + "|" + rs.rows.item(i).profileHost
                                + "|" + rs.rows.item(i).profilePort
                                + "|" + rs.rows.item(i).profileUser
                                + "|" + rs.rows.item(i).profilePass
                                + "|" + rs.rows.item(i).profileCommand
                    )
                }


            }
        )
    }

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
                id: profileHostField
                placeholderText: "Host"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: profileNameField.y+profileNameField.height
            }

            TextField {
                id: profilePortField
                placeholderText: "Port"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: profileHostField.y+profileHostField.height
            }

            TextField {
                id: profileUsernameField
                placeholderText: "Username"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: profilePortField.y+profilePortField.height
            }

            TextField {
                id: profilePasswordField
                placeholderText: "Password"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: profileUsernameField.y+profileUsernameField.height
                echoMode: TextInput.Password
            }

            TextField {
                id: profileCommandField
                placeholderText: "Command"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: profilePasswordField.y+profilePasswordField.height
            }

            Button{
                id: profileSave
                text: "Save Profile"
                y: profileCommandField.y+profileCommandField.height

                onClicked: {
                    profileName=profileNameField.text
                    profileHost=profileHostField.text
                    profilePort=profilePortField.text
                    profileUsername=profileUsernameField.text
                    profilePassword=profilePasswordField.text
                    profileCommand=profileCommandField.text
                    saveProfile()
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





