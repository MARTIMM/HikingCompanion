#include "textload.h"

#include <QDebug>

// ----------------------------------------------------------------------------
Q_LOGGING_CATEGORY( textload, "hc.textload")

// ----------------------------------------------------------------------------
TextLoad::TextLoad(QObject *parent) : QObject(parent) {
  qCInfo(textload) << QString("TextLoad init");
}

// ----------------------------------------------------------------------------
QString TextLoad::filename() {
  return _source;
}

// ----------------------------------------------------------------------------
QString TextLoad::text() {
  return _loadedText;
}

// ----------------------------------------------------------------------------
void TextLoad::setFilename(QString filename) {

  qCInfo(textload) << QString("set filename %1").arg(filename);

  // read the file
  QFile f (filename);
  if ( !f.open( QIODevice::ReadOnly | QIODevice::Text) ) {
    qCWarning(textload) << QString("Open file %1: %2").arg(filename).arg(f.errorString());
    return;
  }

  _source = filename;
  _loadedText = "";
  while ( !f.atEnd() ) { _loadedText += f.readLine(); }
  f.close();
  qCDebug(textload) << _loadedText;

  qCInfo(textload) << "emit textReady";
  emit textReady();
}

