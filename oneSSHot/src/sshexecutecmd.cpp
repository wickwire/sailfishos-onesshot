#include "sshexecutecmd.h"
#include <QProcess>
#include <QDebug>

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

    QString result=proc->readAllStandardOutput();
    qDebug() << "cmd result: " + result;
    //ui->textBrowser->setText(result); //writing the result to my text browser
}
