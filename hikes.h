#ifndef HIKES_H
#define HIKES_H

#include <QObject>

// ----------------------------------------------------------------------------
class Hikes : public QObject {

  Q_OBJECT

public:
  explicit Hikes(QObject *parent = nullptr);

  Q_INVOKABLE void defineHikeList();
  Q_INVOKABLE QStringList hikeList();
  Q_INVOKABLE void defineTrackList();
  Q_INVOKABLE QStringList trackList();

signals:
  void hikeListDefined();
  void trackListDefined();

public slots:

private:
  // title => hike table name. titles from the tables are shown in the drop
  // list and after selection it must be used to find the table.
  QStringList _hikeList;
  QStringList _trackList;
};

#endif // HIKES_H
