#include "sshexecutecmd.h"
#include <QProcess>
#include <QDebug>

sshExecuteCmd::sshExecuteCmd(QObject *parent) :
    QObject(parent)
{
}

void sshExecuteCmd::executeSSH(){

    QString username, host, port, command;

    username="wickwire";
    host="192.168.55.100";
    port="22";
    command="echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt";

    QProcess *proc = new QProcess();

    //proc->start("ssh wickwire@192.168.55.100 -p 22 echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt");
    //proc->waitForFinished();

    //proc->startDetached("ssh wickwire@192.168.55.100 -p 22 echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt");
    proc->startDetached("ssh " + username + "@" + host + " -p " + port + " " + command);

    QString result=proc->readAllStandardOutput();
    qDebug() << "cmd result: " + result;
    //ui->textBrowser->setText(result); //writing the result to my text browser
}
