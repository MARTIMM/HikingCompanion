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

public:
  explicit Config(QObject *parent = nullptr);
//  Config *instance(QObject *parent = nullptr);

  QString osType();

signals:

public slots:

private:
  QString _osType;
//  static Config *_instance;
};

#endif // CONFIG_H
