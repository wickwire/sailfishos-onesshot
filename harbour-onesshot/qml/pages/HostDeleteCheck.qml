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

    property var hosts2del : []
    property var hostsArray : []

    property var profilesArray : []

    ListModel{
        id: profiles4HostModel

        Component.onCompleted: {
            dbFunction.listProfiles4host()
        }
    }

        PageHeader {
                        title: "Confirmation Step"
                    }

            Label{
                id: delDisclaimer
                y: 100
                width: parent.width
                wrapMode: Text.WordWrap
                text: "
        * Any Profiles listed below depend one or more of the Hosts about to be removed.\n
        * Said Profiles will also be removed - if you wish to avoid it, Cancel the action and edit the profiles from the Home Screen by using Long Press.\n\n
        "
            }

            SilicaListView{
                y: delDisclaimer.height+delDisclaimer.y
                width:parent.width
                height: parent.height-delDisclaimer.height*1.2
                model: profiles4HostModel
                delegate: BackgroundItem {
                    Label {
                        text: name
                    }
                }

                VerticalScrollDecorator {}


                Dialog {

                    id: deletedOK

                    Text{
                        width: parent.width
                        text: "Hosts/Profiles deleted!"
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

            Button{
                id: profileDel
                text: "Delete"
                anchors.right: parent.right
                y: profileDelAbort.y-profileDelAbort.height

                onClicked: {
                    hostsArray=hosts2del
                    dbFunction.deleteHosts()
                    dbFunction.deleteProfiles()
                    var dialog = pageStack.push(deletedOK)
                }
            }

            Button{
                id: profileDelAbort
                text: "Cancel"
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                onClicked: {
                    pageStack.clear()
                    pageStack.push("HomeScreen.qml")
                }
            }
}
