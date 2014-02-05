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

CoverBackground {

         Image {

             id: logo
             source: "/usr/share/icons/hicolor/86x86/apps/harbour-onesshot.png"
             anchors.centerIn: parent

//             RotationAnimation on rotation {
//                 running: active
//                 duration: 1000
//                 loops: Animation.Infinite
//                 from: 0
//                 to: 360
//             }


        SequentialAnimation{
            running: true
            loops: Animation.Infinite

            NumberAnimation{
                target:logo
                property: "opacity"
                duration: 1
                from: 0
                to: 1
            }

            //inbetween


            NumberAnimation{
                target:logo
                property: "rotation"
                duration: 100
                from: 0
                to: 360
                loops: 10
            }

            NumberAnimation{
                target:logo
                property: "rotation"
                duration: 200
                from: 0
                to: 360
                loops: 8
            }

            NumberAnimation{
                target:logo
                property: "rotation"
                duration: 500
                from: 0
                to: 360
                loops:5
            }

            NumberAnimation{
                target:logo
                property: "rotation"
                duration: 750
                from: 0
                to: 360
                loops:3
            }

            NumberAnimation{
                target:logo
                property: "rotation"
                duration: 1000
                from: 0
                to: 360
                loops:1
            }

            NumberAnimation {
                target:logo
                property: "scale"
                duration: 1500
                from: 1
                to: 30
            }
            //inbetween

             NumberAnimation {
                 target:logo
                 property: "scale"
                 duration: 3000
                 from: 30
                 to: 1
             }

             NumberAnimation {
                target:logo
                property: "opacity"
                duration: 1000
                from: 1
                to: 0
             }

          }

         }

}


