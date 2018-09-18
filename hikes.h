#ifndef HIKES_H
#define HIKES_H

#include <QObject>
#include <QVariantList>

// ----------------------------------------------------------------------------
class Hikes : public QObject {

  Q_OBJECT

public:
  explicit Hikes(QObject *parent = nullptr);

  Q_INVOKABLE void defineHikeList();
  Q_INVOKABLE QStringList hikeList();
  Q_INVOKABLE QVariantList trackList();

signals:
  void hikeListDefined();

public slots:

private:
  // title => hike table name. titles from the tables are shown in the drop
  // list and after selection it must be used to find the table.
  QStringList _hikeList;
  QVariantList _trackList;
};

#endif // HIKES_H
