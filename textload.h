#ifndef TEXTLOAD_H
#define TEXTLOAD_H

#include <QDebug>
#include <QObject>
#include <QString>
#include <QFile>

// ----------------------------------------------------------------------------
class TextLoad : public QObject {
  Q_OBJECT
  Q_PROPERTY( QString filename READ filename)
  Q_PROPERTY( QString text READ text)
  Q_PROPERTY( QString setFilename WRITE setFilename NOTIFY fileRead)

public:
  explicit TextLoad(QObject *parent = nullptr);

  QString filename();
  void setFilename(QString filename);
  QString text();

signals:
  void fileRead();

public slots:

private:
  QString _source;
  QString _loadedText;
};

#endif // TEXTLOAD_H
