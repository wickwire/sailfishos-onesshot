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

#include <QCoreApplication>
#include <QStandardPaths>
#include <QDir>

#include <QThread>
#include <QObject>


sshExecuteCmd::sshExecuteCmd(QObject *parent) :
    QObject(parent)
{
}

void sshExecuteCmd::executeSSH(QString qmlusername, QString qmladdress, QString qmlport, QString qmlcommand){

    QString qtaddress, qtport, qtusername, qtcommand;
    QProcess *proc = new QProcess();
    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    qtaddress=qmladdress;
    qtport=qmlport;
    qtusername=qmlusername;
    qtcommand=qmlcommand;

    QStringList sshArgs;

    sshArgs.append("onesshot");

    qDebug()<< "ssh " + qtusername + "@" + qtaddress + " -p " + qtport + " -o StrictHostKeyChecking=no " + qtcommand;
    //proc->start("ssh -i /home/nemo/.local/share/harbour-onesshot/harbour-onesshot/id_rsa nunofaria@192.168.1.15 -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/home/nemo/.local/share/harbour-onesshot/harbour-onesshot/known_hosts echo 'SailfishOS: '`date` > /tmp/sailfishOS.tmp");

    proc->start("ssh -i " + data_dir + "/id_rsa " + qtusername + "@" + qtaddress + " -p " + qtport + " -o StrictHostKeyChecking=no -o UserKnownHostsFile=" + data_dir + "/known_hosts " + qtcommand,sshArgs);

}

void sshExecuteCmd::genKey(){

    //QObject::connect(this, SIGNAL(spinnerStateUpdated()), this, SLOT(emitSpinnerState()));

    //QString config_dir = QDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)).filePath(QCoreApplication::applicationName());
    //QString data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    //QString cache_dir = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    //qDebug() << "env_dirs: " + config_dir + " " + data_dir + " " + cache_dir;

    qDebug("Thread ID @genKey: %d",(int)QThread::currentThreadId());

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QProcess *proc = new QProcess();
    QProcess *procClean = new QProcess();

    qDebug() << "data_dir:::: " + data_dir;

    //find/read public key half
    QFile pubKey(data_dir + "/id_rsa.pub");

    if (!pubKey.exists()){
           procClean->start("killall ssh-keygen");
           procClean->waitForFinished();
           procClean->close();
           proc->startDetached("ssh-keygen -t rsa -b 2048 -f " + data_dir + "/id_rsa");

           checkKeysExist();

    }

    cplusplus_spinnerState=false;

    emit spinnerStateUpdated();
}

QString sshExecuteCmd::readKey(){

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QFile pubKey(data_dir + "/id_rsa.pub");

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

bool sshExecuteCmd::getSpinnerState(){

    return cplusplus_spinnerState;

    emit finished();

}

void sshExecuteCmd::setSpinnerState(bool spinState){

    cplusplus_spinnerState=spinState;

}

void sshExecuteCmd::spinIt(){

    //cplusplus_spinnerState=true;

    setSpinnerState(true);

    emit spinnerStateUpdated();

}

void sshExecuteCmd::stopSpinningIt(){

    //cplusplus_spinnerState=true;

    setSpinnerState(false);

    emit spinnerStateUpdated();

}

void sshExecuteCmd::emitSpinnerState(){

    setSpinnerState(false);

    qDebug("FUNCIONOU: %d",(int)QThread::currentThreadId());

    emit finished();
}

void sshExecuteCmd::checkKeysExist(){


    QEventLoop q;
    QTimer tT;

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QFile pubKey(data_dir + "/id_rsa.pub");

    QObject::connect(&tT, SIGNAL(timeout()),&q, SLOT(quit()));

    QObject::connect(&pubKey, SIGNAL(spinnerStateUpdated()),

            &q, SLOT(quit()));

    tT.start(3000); // 3s timeout

    q.exec();

}
