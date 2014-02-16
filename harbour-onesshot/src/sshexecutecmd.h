#ifndef SSHEXECUTECMD_H
#define SSHEXECUTECMD_H

#include <QObject>
#include <QDebug>

class sshExecuteCmd : public QObject
{
    Q_PROPERTY(QString pubKey READ getPubKey NOTIFY pubKeyUpdated)
    Q_PROPERTY(QString pubKeyURL READ getPubKeyURL NOTIFY pubKeyURLUpdated)
    Q_PROPERTY(bool spinnerState READ getSpinnerState WRITE setSpinnerState NOTIFY spinnerStateUpdated)
    //Q_PROPERTY(bool keysGenerated READ getKeysGenerated NOTIFY keysGeneratedUpdated)

    Q_OBJECT
public:
    explicit sshExecuteCmd(QObject *parent = 0);
    QString cplusplus_pubKey;
    QString cplusplus_pubKeyURL;
    bool cplusplus_spinnerState;
    QString getPubKey();
    QString getPubKeyURL();
    bool getSpinnerState();
    void setSpinnerState(bool);
    //bool getKeysGenerated();
    QString data_dir;
signals:
    QVariant pubKeyUpdated(QVariant sshkey);
    QVariant pubKeyURLUpdated(QVariant sshkeyURL);
    QVariant spinnerStateUpdated();
    //QVariant keysGeneratedUpdated();

    void finished();

public slots:
    void executeSSH(QString qmlusername, QString qmladdress, QString qmlport, QString qmlcommand);
    void genKey();
    QString readKey();
    void publishPubKey(QString keyString);
    void emitSpinnerState();
    void spinIt();
    void stopSpinningIt();
    void checkGeneratedKeys();
    bool checkExistingKeys();

};

#endif // SSHEXECUTECMD_H
