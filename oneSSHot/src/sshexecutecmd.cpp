#include "sshexecutecmd.h"
#include <QProcess>
#include <QDebug>

sshExecuteCmd::sshExecuteCmd(QObject *parent) :
    QObject(parent)
{
}

void sshExecuteCmd::executeSSH(){

    QProcess *proc = new QProcess();

    proc->start("ssh wickwire@192.168.55.100 echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt");
    proc->waitForFinished();

    QString result=proc->readAllStandardOutput();
    qDebug() << "cmd result: " + result;
    //ui->textBrowser->setText(result); //writing the result to my text browser
}
