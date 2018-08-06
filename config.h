#ifndef CONFIG_H
#define CONFIG_H

#include <QDebug>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>

class Config : public QObject
{
  Q_OBJECT
  Q_PROPERTY( QString osType READ osType)
//  Q_PROPERTY( QString instance READ instance)
  Q_PROPERTY( QString username READ username WRITE setUsername NOTIFY usernameChanged)

public:
  explicit Config(QObject *parent = nullptr);
//  Config *instance(QObject *parent = nullptr);

  QString osType();
  QString username();
  void setUsername(QString *username);

signals:
  void usernameChanged();

public slots:

private:
  QString _osType;
//  static Config *_instance;
};

#endif // CONFIG_H
