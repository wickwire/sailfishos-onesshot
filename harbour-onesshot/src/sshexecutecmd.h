#ifndef SSHEXECUTECMD_H
#define SSHEXECUTECMD_H

#include <QObject>
#include <QDebug>

class sshExecuteCmd : public QObject
{
    Q_PROPERTY(QString pubKey READ getPubKey NOTIFY pubKeyUpdated)
    Q_PROPERTY(QString pubKeyURL READ getPubKeyURL NOTIFY pubKeyURLUpdated)
    Q_PROPERTY(QString spinnerState READ getSpinnerState NOTIFY spinnerStateUpdated)

    Q_OBJECT
public:
    explicit sshExecuteCmd(QObject *parent = 0);
    QString cplusplus_pubKey;
    QString cplusplus_pubKeyURL;
    QString cplusplus_spinnerState;
    QString getPubKey();
    QString getPubKeyURL();
    QString getSpinnerState();
    QString data_dir;

signals:
    QVariant pubKeyUpdated(QVariant sshkey);
    QVariant pubKeyURLUpdated(QVariant sshkeyURL);
    QVariant spinnerStateUpdated(QVariant spinnerState);

    void finished();

public slots:
    void executeSSH(QString qmlusername, QString qmladdress, QString qmlport, QString qmlcommand);
    void genKey();
    QString readKey();
    void publishPubKey(QString keyString);
    void cenas();
};

#endif // SSHEXECUTECMD_H
