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
  Q_INVOKABLE void setSetting( QString name, int value);
  Q_INVOKABLE QString getSetting(QString name, QSettings *s = nullptr);

  QStringList readKeys( QString group, QSettings *s = nullptr);
  void installNewData(QString dataPath);
  QString hikeEntryKey();
  QString hikeTableName(QString hikeEntryKey);
  QString tracksTableName( QString hikeTableName, int trackCount);

signals:

public slots:

private:
  void _mkNewTables( QSettings *s,  QString hikeTableName);
  void _refreshData(
      QSettings *s,
      QString hikeTableName,
      QString hikeDir,
      QString dataPath
      );
  void _removeSettings(QString group);

  QString _dataDir;
};

#endif // CONFIG_H
