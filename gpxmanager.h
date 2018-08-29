#ifndef GPXMANAGER_H
#define GPXMANAGER_H
/*
 * Manager reads a given directory for gpx data stored in files. These files
 * are appended to a list. This list is shown on the qml tracksPage. Clicking
 * on a track from the list will set the current track in the manager and
 * in the Config object. The manager will read the data and hand the data
 * over to the mapPage.
 *
 * The gpx path will be provided by the Config class.
*/

#include <QObject>

// ----------------------------------------------------------------------------
class GpxManager : public QObject {

  Q_OBJECT

public:
  explicit GpxManager(QObject *parent = nullptr);

signals:

public slots:

private:
};

#endif // GPXMANAGER_H
