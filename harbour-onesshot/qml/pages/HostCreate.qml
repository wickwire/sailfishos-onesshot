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

    property int hostId
    property string hostName
    property string hostAddress
    property int hostPort
    property string hostUser

    SilicaListView {
        id: listView
        model: 1
        anchors.fill: parent
        header: PageHeader {
            title: "Add Host"
        }
        delegate: BackgroundItem {
            id: delegate

            TextField {
                id: hostNameField
                placeholderText: "Host Name"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
            }

            TextField {
                id: hostAddressField
                placeholderText: "Address"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: hostNameField.y+hostNameField.height
            }

            TextField {
                id: hostPortField
                placeholderText: "Port"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: hostAddressField.y+hostAddressField.height
            }

            TextField {
                id: hostUserField
                placeholderText: "User"
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
                height: 100
                y: hostPortField.y+hostPortField.height
            }

            Button{
                id: hostAdd
                text: "Add Host"
                y: hostUserField.y+hostUserField.height

                onClicked: {
                    hostName=hostNameField.text
                    hostAddress=hostAddressField.text
                    hostPort=hostPortField.text
                    hostUser=hostUserField.text

                    console.log("hostName: " + hostName + "hostAddress: " + hostAddress + "hostPort: " + hostPort + "hostUser: " + hostUser)

                    sshCmd.genKey()

                    dbFunction.addHost(hostAddress)
                    var dialog = pageStack.push(addedOK)
                }
            }


            Dialog {

                id: addedOK
                objectName: "hostAdded"

                Text{
                    width: parent.width
                    text: "Host added Successfully!\n\n Your Public Key is available in the pull-down menu. Add it to this host authorized_keys file.\n\n"
                    wrapMode: Text.Wrap
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
    }
}





