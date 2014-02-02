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

void sshExecuteCmd::executeSSH(QString qmlusername, QString qmlhost, QString qmlport, QString qmlcommand){

    QString qthost, qtport, qtusername, qtcommand;
    QProcess *proc = new QProcess();

    //username="wickwire";
    //host="192.168.55.100";
    //port="22";
    //command="echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt";

    //proc->start("ssh wickwire@192.168.55.100 -p 22 echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt");
    //proc->waitForFinished();
    //proc->startDetached("ssh wickwire@192.168.55.100 -p 22 echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt");

    qthost=qmlhost;
    qtport=qmlport;
    qtusername=qmlusername;
    qtcommand=qmlcommand;

    proc->startDetached("ssh " + qtusername + "@" + qthost + " -p " + qtport + " " + qtcommand);
}

void sshExecuteCmd::pushPubKey(QString qmlhost, int qmlport, QString qmlusername){
    QString qthost, qtusername;
    int qtport;
    QProcess *proc = new QProcess();
    qthost=qmlhost;
    qtport=qmlport;
    qtusername=qmlusername;

    //check if a private/public keypair exists.
    //if it doesn't, generate it:
    //ssh-keygen -t rsa -b 2048 -f /home/nemo/.ssh/id_rsa -N ''

    //to be done at a later stage, if at all
    //push the public key half to the remote server
    //ssh-copy-id <user>@<host> (this requires password input, only once - can be a problem)
    //send the public key half to QML for display (dialog/page information)

    //find/read public key half
    QFile pubKey("/home/nemo/.ssh/id_rsa.pub");
    if (!pubKey.open(QIODevice::ReadOnly | QIODevice::Text))
             return;

    if(!pubKey.exists())
    {
      qDebug("ssh key pair not found, generating...");
      proc->start("ssh-keygen -t rsa -b 2048 -f /home/nemo/.ssh/id_rsa");
      qDebug("ssh key pair generated successfully!");
    }

    QTextStream textStream(&pubKey);
    QString keyString = textStream.readAll();
    pubKey.close();

    //publish the public half to hastebin
    hasteBinIt(keyString);

    //outputs the string inside id_rsa.pub, this is the public key
    qDebug() << keyString;

}


void sshExecuteCmd::hasteBinIt(QString keyString){

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

    tT.start(1000); // 1s timeout

    q.exec();

    if(tT.isActive()){

        // download complete
        hasteBinJSON = reply->readAll().data();

        QJsonDocument doc = QJsonDocument::fromJson(hasteBinJSON);
        QJsonObject obj = doc.object();
        QJsonValue hastebinKey = obj.value("key");

        qDebug() <<  "http://hastebin.com/" + hastebinKey.toString();

        tT.stop();

    } else {

        qDebug() <<  "Timeout";

        // timeout

    }

}
