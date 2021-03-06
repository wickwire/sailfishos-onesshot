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

    property bool readingKeys: false

    BusyIndicator {
        id: readKeySpinner
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: sshCmd.spinnerState

        states: [
            State {
                name: "spinning"
                when: sshCmd.spinnerState==true
            },
            State {
                name: "stopped"
                when: sshCmd.spinnerState==false
            }
        ]

        onStateChanged: {
            if (state == "spinning"){
                console.log("READ SPINNER ON")
                readingKeys=true
            }

            if (state == "stopped"){
                if(readingKeys==true){
                    console.log("READ SPINNER OFF AND KEYS OK: " + sshReadKeyValue.pubKey + " -- " + sshReadKeyValue.pubKeyURL)
                    var pubKeyData = {
                        "publickey" : sshReadKeyValue.pubKey,
                        "publickeyURL" : sshReadKeyValue.pubKeyURL
                    };
                    pageStack.push("GetSSHKey.qml",pubKeyData)
                }
            }
        }
    }

    RemorsePopup {
        id: remorse
        onTriggered: {
            sshDelKey.start()
            var dialog = pageStack.push(deletedOK)
        }
    }

    Dialog {

        id: deletedOK
        objectName: "keysDelete"

        Text{
            width: parent.width
            text: "SSH Keys successfully deleted!\n\n"
            wrapMode: Text.Wrap
            color: "white"
            y: 100
            anchors.horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            sshDelKey.quit()
            pageStack.clear()
            pageStack.push("HomeScreen.qml")
        }
    }

    Column {
        anchors.fill: parent
        width: parent.width

        PageHeader {
            title: "Manage SSH Keys"
        }

        Button{
            id: getPubKey
            text: "Show Public Key"
            onClicked: {
                sshReadKey.start()
            }
        }

        Button{
            id: delKeys
            text: "Delete SSH keys"
            onClicked: remorse.execute("Are you sure...?")
        }

    }
}





