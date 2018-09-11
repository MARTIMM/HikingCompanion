#ifndef CONFIG_H
#define CONFIG_H

#include "gpxfile.h"

#include <QGuiApplication>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>
#include <QQmlListProperty>

class Config : public QObject {
  Q_OBJECT

  //Q_PROPERTY( QGuiApplication appObject READ appObject WRITE setAppObject)


public:
  Config(QObject *parent = nullptr);

  // language enumerations, only a few
  enum Languages { English, Nederlands };
  const static int nbrLang = 2;
  Q_ENUM(Languages)

  // What system
  //QString osType();
/*
  QGuiApplication *appObject();
  void setAppObject(QGuiApplication *appObjectPtr);
*/

  Q_INVOKABLE void setSetting( QString name, QString value);
  Q_INVOKABLE QString getSetting(QString name);

signals:

public slots:

private:
//  QGuiApplication *_appObject;
};

#endif // CONFIG_H
