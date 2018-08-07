#ifndef CONFIG_H
#define CONFIG_H

#include <QDebug>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>

class Config : public QObject
{
  Q_OBJECT
  Q_PROPERTY( QString osType READ osType)
  Q_PROPERTY( QString username READ username
              WRITE setUsername NOTIFY usernameChanged
              )
  Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
  Q_PROPERTY(int language READ language WRITE setLanguage NOTIFY languageChanged)
  Q_PROPERTY(bool emitIt READ emitIt WRITE setEmitIt)
  Q_PROPERTY(bool readProperties READ readProperties)

public:
  explicit Config(QObject *parent = nullptr);

  QString osType();
  QString username();
  QString email();
  int language();
  bool readProperties();
  bool emitIt();

  void setUsername( const QString username, const bool emitIt = false);
  void setEmail( const QString email, const bool emitIt = false);
  void setLanguage( const int language, const bool emitIt = false);
  void setEmitIt(const bool emitIt = false);

signals:
  void usernameChanged();
  void emailChanged();
  void languageChanged();

public slots:

private:
  QString _osType;
  QString _username;
  QString _email;
  int _language;
  bool _emitIt = false;
};

#endif // CONFIG_H
