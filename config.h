#ifndef CONFIG_H
#define CONFIG_H

#include "gpxfile.h"

#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>
#include <QQmlListProperty>

class Config : public QObject {

  Q_OBJECT

public:
  Config(QObject *parent = nullptr);

  // language enumerations, only a few
  //enum Languages { English, Nederlands };
  //const static int nbrLang = 2;
  //Q_ENUM(Languages)

  Q_INVOKABLE void setSetting( QString name, QString value);
  Q_INVOKABLE QString getSetting(QString name);

  Q_INVOKABLE QStringList readKeys(QString group);

  void installNewData(QString dataPath);

signals:

public slots:

private:
  void _mkNewTable( QSettings *s, QString hikeTableName);
  void _refreshData(
      QSettings *s,
      QString hikeEntryKey,
      QString hikeTableName,
      QString hikeDir
      );
  void _removeSettings(QString group);

  QString _dataDir;
};

#endif // CONFIG_H
