#include "sshexecutecmd.h"
#include <QProcess>
#include <QDebug>
#include <QFile>
#include <QIODevice>
#include <QTextStream>
#include <QStringList>

#include <QTimer>
#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>


sshExecuteCmd::sshExecuteCmd(QObject *parent) :
    QObject(parent)
{
}

void sshExecuteCmd::executeSSH(QString qmlusername, QString qmladdress, QString qmlport, QString qmlcommand){

    QString qtaddress, qtport, qtusername, qtcommand;
    QProcess *proc = new QProcess();

    qtaddress=qmladdress;
    qtport=qmlport;
    qtusername=qmlusername;
    qtcommand=qmlcommand;

    qDebug()<< "ssh " + qtusername + "@" + qtaddress + " -p " + qtport + " -o StrictHostKeyChecking=no " + qtcommand;
    proc->start("ssh " + qtusername + "@" + qtaddress + " -p " + qtport + " -o StrictHostKeyChecking=no " + qtcommand);
}

void sshExecuteCmd::genKey(){

    QProcess *proc = new QProcess();

    //find/read public key half
    QString homeDir = "/home/nemo";
    QFile pubKey(homeDir+"/.ssh/id_rsa.pub");

       //if (!pubKey.open(QIODevice::ReadOnly | QIODevice::Text))
       //    return;

    if(!pubKey.exists())
    {
      qDebug("ssh key pair not found, generating...");
      proc->start("ssh-keygen -t rsa -b 2048 -f "+homeDir+"/.ssh/id_rsa");
      proc->waitForFinished();
      qDebug("ssh key pair generated successfully!");
    }

    /*
    qDebug("ssh key pair reading...");
    //read the public half
    QString keyString=readKey();

    //publish the public half to hastebin
    publishPubKey(keyString);

    cplusplus_pubKey = keyString;
    emit pubKeyUpdated(cplusplus_pubKey);
    //outputs the string inside id_rsa.pub, this is the public key
    qDebug() << keyString;
    */

}

QString sshExecuteCmd::readKey(){
    QString homeDir = "/home/nemo";
    QFile pubKey(homeDir+"/.ssh/id_rsa.pub");

    pubKey.open(QIODevice::ReadOnly | QIODevice::Text);

    QTextStream textStream(&pubKey);
    QString keyString = textStream.readAll();
    pubKey.close();
    return keyString;
}

void sshExecuteCmd::publishPubKey(QString keyString){

    QNetworkAccessManager manager;
    QEventLoop q;
    QTimer tT;

    QNetworkRequest request;
    QByteArray postData;

    postData.append(keyString);

    QByteArray hasteBinJSON;

    request.setRawHeader("Content-Type", "application/x-www-form-urlencoded");
    request.setUrl(QUrl("http://hastebin.com/documents"));

    tT.setSingleShot(true);

    QObject::connect(&tT, SIGNAL(timeout()),&q, SLOT(quit()));

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)),

            &q, SLOT(quit()));

    QNetworkReply *reply = manager.post(request, postData);

    tT.start(2000); // 2s timeout

    q.exec();

    if(tT.isActive()){

        // download complete
        hasteBinJSON = reply->readAll().data();

        QJsonDocument doc = QJsonDocument::fromJson(hasteBinJSON);
        QJsonObject obj = doc.object();
        QJsonValue hastebinKey = obj.value("key");


        cplusplus_pubKeyURL = hastebinKey.toString();
        emit pubKeyURLUpdated(cplusplus_pubKeyURL);

        qDebug() <<  "http://hastebin.com/" + hastebinKey.toString();

        tT.stop();

    } else {

        qDebug() <<  "Timeout";

        // timeout

    }

}

QString sshExecuteCmd::getPubKey(){

    return cplusplus_pubKey;

    emit finished();

}

QString sshExecuteCmd::getPubKeyURL(){

    return "http://hastebin.com/" + cplusplus_pubKeyURL;

    emit finished();

}
