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
    SilicaListView {
        id: listView
        model: 1
        anchors.fill: parent
        header: PageHeader {
            title: "About oneSSHot"
        }
        delegate: BackgroundItem {
            id: delegate
            height: about.height
            Label {
                id: about
                width: parent.width
                wrapMode: Text.WordWrap
                text: "
* oneSSHot works by automating commands over SSH to remote (either LAN or internet accessible) systems. It is then up to the remote system to act accordingly to the received command.\n\n
* This app came out of the necessity to quickly issue shutdown commands to several systems throughout the house.\n\n
* It can be used to do a lot more than that, since any command can be sent to remote system.\n\n
* The authentication method used is by generating public/private ssh key pairs and publishing the public key to the remote system.\n\n
* This app was first intended for Android (1.6 at the time) but a few weeks prior to market publishing, I found out that another developer had already submitted a similar app called Lazier Geek.\n\n
* Since I couldn't find a match in the Jolla Store, I thought I'd resume my old project and improve upon it!\n\n\n
"
            }
        }
        VerticalScrollDecorator {}
    }
}





