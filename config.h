#ifndef CONFIG_H
#define CONFIG_H

#include "gpxfile.h"

#include <QObject>
#include <QSettings>


class Config : public QObject {

  Q_OBJECT

public:
  Config(QObject *parent = nullptr);

  QString dataDir();
  QString dataShareDir();

  Q_INVOKABLE void checkForNewHikeData();
  Q_INVOKABLE void cleanupTracks();
  Q_INVOKABLE void cleanupHike();

  Q_INVOKABLE void setSetting( QString name, QString value);
  Q_INVOKABLE void setSetting( QString name, int value);
  Q_INVOKABLE QString getSetting(QString name, QSettings *s = nullptr);

  QStringList readKeys( QString group, QSettings *s = nullptr);
  QString hikeEntryKey();
  QString hikeTableName(QString hikeEntryKey);
  QString tracksTableName( QString hikeTableName, int trackCount);

  Q_INVOKABLE void setGpxFileIndexSetting(int currentIndex);
  Q_INVOKABLE int getGpxFileIndexSetting();

  Q_INVOKABLE QString getHtmlPageFilename( QString pageName);

  Q_INVOKABLE QString getTheme();

  Q_INVOKABLE QString getHCVersion();
  Q_INVOKABLE QStringList getHikeVersions();
  Q_INVOKABLE QStringList getVersions();

  //bool mkpath(QString path);

signals:

public slots:

private:
};

#endif // CONFIG_H
