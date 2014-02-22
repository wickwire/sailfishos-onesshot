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
* version 0.5 release 1\n
* oneSSHot works by automating commands over SSH to remote (either LAN or internet accessible) systems.\n
* To start working with oneSSHot, do as follows:\n
** Add a Host. If no Public/Private Key Pairs exist on your device, they will be generated in the .local/share/harbour-onesshot app directory\n
** Get the Public Key from oneSSHot and configure it on the authorized_keys file at the remote server\n
** Add a Profile and associate it with an existing Host\n
** Tap a Profile to fire its command to the designated host\n
* Update a Profile using Long Press in the Home Screen\n\n
* This app served as an experiment with the SailfishOS platform, it is fully functional but bugs may pop up now and then.\n
* It is serving me well in shutting down headless servers, but the possibilities are endless!
"
            }
        }
        VerticalScrollDecorator {}
    }
}





