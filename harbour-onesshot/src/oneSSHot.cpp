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

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include "sshexecutecmd.h"
#include "sqlitedb.h"

#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlComponent>

#include <QThread>

int main(int argc, char *argv[])
{
    // For this example, wizard-generates single line code would be good enough,
    // but very soon it won't be enough for you anyway, so use this more detailed example from start
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

// Here's how you will add QML components whenever you start using them
// Check https://github.com/amarchen/Wikipedia for a more full example
// view->engine()->addImportPath(SailfishApp::pathTo("qml/components").toString());

    sshExecuteCmd *sshCmd = new sshExecuteCmd();

    sshCmd->setSpinnerState(false);

    sshExecuteCmd *sshGenKey = new sshExecuteCmd();

    sshExecuteCmd *sshDelKey = new sshExecuteCmd();

    sshExecuteCmd *sshReadKey = new sshExecuteCmd();

    QThread* sshGenKeythread = new QThread;

    QThread* sshDelKeythread = new QThread;

    QThread* sshReadKeythread = new QThread;

    qDebug("Main Thread ID: %d",(int)QGuiApplication::instance()->thread());

    sqliteDB *onesshotDB = new sqliteDB();

    onesshotDB->createDB();



    sshGenKey->moveToThread(sshGenKeythread);

    QObject::connect(sshGenKeythread, SIGNAL(started()), sshGenKey, SLOT(genKey()),Qt::QueuedConnection);
    QObject::connect(sshGenKeythread, SIGNAL(started()), sshCmd, SLOT(spinIt()));
    QObject::connect(sshGenKey, SIGNAL(spinnerStateUpdated()), sshCmd, SLOT(stopSpinningIt()));
    QObject::connect(sshGenKey, SIGNAL(finished()), sshCmd, SLOT(stopSpinningIt()));


    sshDelKey->moveToThread(sshDelKeythread);

    QObject::connect(sshDelKeythread, SIGNAL(started()), sshDelKey, SLOT(deleteKeys()),Qt::QueuedConnection);
    QObject::connect(sshDelKeythread, SIGNAL(started()), sshCmd, SLOT(spinIt()));
    QObject::connect(sshDelKey, SIGNAL(keysDeletedUpdated()), sshCmd, SLOT(stopSpinningIt()));



    sshReadKey->moveToThread(sshReadKeythread);

    QObject::connect(sshReadKeythread, SIGNAL(started()), sshReadKey, SLOT(readKey()),Qt::QueuedConnection);
    QObject::connect(sshReadKeythread, SIGNAL(started()), sshCmd, SLOT(spinIt()));
    QObject::connect(sshReadKey, SIGNAL(pubKeyURLUpdated(QString)), sshCmd, SLOT(stopSpinningIt()));
    QObject::connect(sshReadKey, SIGNAL(pubKeyURLUpdated(QString)), sshReadKey, SLOT(getPubKey()));
    QObject::connect(sshReadKey, SIGNAL(pubKeyURLUpdated(QString)), sshReadKey, SLOT(getPubKeyURL()));


    view->rootContext()->setContextProperty("sshGenKey", sshGenKeythread);

    view->rootContext()->setContextProperty("sshDelKey", sshDelKeythread);

    view->rootContext()->setContextProperty("sshReadKey", sshReadKeythread);

    view->rootContext()->setContextProperty("sshReadKeyValue", sshReadKey);

    view->rootContext()->setContextProperty("sshCmd", sshCmd);

    view->setSource(SailfishApp::pathTo("qml/oneSSHot.qml"));

    view->show();


    return app->exec();
}

