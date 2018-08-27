#ifndef LANGUAGE_H
#define LANGUAGE_H

#include <QObject>

// ----------------------------------------------------------------------------
class Language : public QObject {

  Q_OBJECT
  Q_PROPERTY( QString name READ name WRITE setName NOTIFY nameChanged)

public:
  explicit Language(QObject *parent = nullptr);

  QString name();
  void setName(QString name);

signals:
  void nameChanged();

public slots:

private:

  QString _name;
};

#endif // LANGUAGE_H
