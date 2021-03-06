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


    qDebug()<< "ssh -X " + qtusername + "@" + qtaddress + " -p " + qtport + " -o StrictHostKeyChecking=no " + qtcommand;
    //proc->start("ssh -X -i /home/nemo/.local/share/harbour-onesshot/harbour-onesshot/id_rsa nunofaria@192.168.1.15 -p 22 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/home/nemo/.local/share/harbour-onesshot/harbour-onesshot/known_hosts echo 'SailfishOS: '`date` > /tmp/sailfishOS.tmp");

    proc->startDetached("ssh -X -i " + data_dir + "/id_rsa " + qtusername + "@" + qtaddress + " -p " + qtport + " -o StrictHostKeyChecking=no -o UserKnownHostsFile=" + data_dir + "/known_hosts " + qtcommand);

}

void sshExecuteCmd::genKey(){

    //QString config_dir = QDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)).filePath(QCoreApplication::applicationName());
    //QString data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    //QString cache_dir = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    //qDebug() << "env_dirs: " + config_dir + " " + data_dir + " " + cache_dir;

    qDebug("Thread ID @genKey: %d",(int)QThread::currentThreadId());

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QProcess *proc = new QProcess();
    QProcess *procClean = new QProcess();

    qDebug() << "data_dir:::: " + data_dir;

    QFile pubKey(data_dir + "/id_rsa.pub");

    if (!pubKey.exists()){
           procClean->start("killall ssh-keygen");
           procClean->waitForFinished();
           procClean->close();
           proc->startDetached("ssh-keygen -t rsa -b 2048 -f " + data_dir + "/id_rsa");


           QTimer * counter = new QTimer;

           this->checkGeneratedKeys();

           QObject::connect(counter, SIGNAL(timeout()), this, SLOT(checkGeneratedKeys()));
           QObject::connect(this, SIGNAL(keysGeneratedUpdated()), counter, SLOT(stop()));
           QObject::connect(this, SIGNAL(keysGeneratedUpdated()), this, SLOT(stopSpinningIt()));
           counter->start(1000);
    }
    else{
        this->stopSpinningIt();
    }

}

void sshExecuteCmd::readKey(){

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QFile pubKey(data_dir + "/id_rsa.pub");

    pubKey.open(QIODevice::ReadOnly | QIODevice::Text);

    QTextStream textStream(&pubKey);
    cplusplus_pubKey = textStream.readAll();
    pubKey.close();

    emit pubKeyUpdated(cplusplus_pubKey);

    publishPubKey();
}

void sshExecuteCmd::publishPubKey(){

    QNetworkAccessManager manager;
    QEventLoop q;
    QTimer tT;

    QNetworkRequest request;
    QByteArray postData;

    postData.append(cplusplus_pubKey);

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

        qDebug() <<  "pubKeyURL - C++ - http://hastebin.com/" << cplusplus_pubKeyURL;

        qDebug() <<  "pubKey - C++ - " << cplusplus_pubKey;

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

    setSpinnerState(false);
    qDebug() << "stop spinning it!";
    emit spinnerStateUpdated();

}

void sshExecuteCmd::emitSpinnerState(){

    setSpinnerState(false);

    qDebug("FUNCIONOU: %d",(int)QThread::currentThreadId());

    emit finished();
}

void sshExecuteCmd::checkGeneratedKeys(){

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QFile pubKey(data_dir + "/id_rsa.pub");

    if(pubKey.exists()){
        qDebug() << pubKey.fileName() << " FOUND!";
        emit keysGeneratedUpdated();
    }
    else{
        qDebug() << pubKey.fileName() << " NOT FOUND!";
    }

}


bool sshExecuteCmd::checkExistingKeys(){

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QFile pubKey(data_dir + "/id_rsa.pub");

    if(pubKey.exists()) {
        qDebug() << "PUBKEY EXISTS!!!";
        this->stopSpinningIt();
        return true;
    }
    else{
        return false;
    }

}

bool sshExecuteCmd::getKeysGenerated(){

    emit finished();

    return true;

}

bool sshExecuteCmd::getKeysDeleted(){

    emit finished();

    return true;

}

void sshExecuteCmd::deleteKeys(){

    setSpinnerState(true);

    data_dir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QFile pubKey(data_dir + "/id_rsa.pub");
    QFile privKey(data_dir + "/id_rsa");
    QFile knownHosts(data_dir + "/known_hosts");

    pubKey.remove();
    qDebug() << "pubKey deleted";
    privKey.remove();
    qDebug() << "privKey deleted";
    knownHosts.remove();
    qDebug() << "known_hosts deleted";


    setSpinnerState(false);

    emit keysDeletedUpdated();

}
