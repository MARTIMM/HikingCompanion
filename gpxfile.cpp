#include "gpxfile.h"

#include <QDebug>
#include <QFile>

// ----------------------------------------------------------------------------
GpxFile::GpxFile(QObject *parent) : QObject(parent) {

}

// ----------------------------------------------------------------------------
QString GpxFile::gpxFilename() {

  return _gpxFilename;
}

// ----------------------------------------------------------------------------
QString GpxFile::gpxDescr ( ) {

  return _gpxDescr;
}

// ----------------------------------------------------------------------------
QString GpxFile::trackName ( ) {

  return _trackName;
}

// ----------------------------------------------------------------------------
void GpxFile::setGpxFilename( QString gpxPath, QString gpxFilename) {

//Todo fiename must be tested
  _gpxFilename =gpxFilename;
  _gpxPath = gpxPath;

  QFile gpxFile (gpxPath + "/" + gpxFilename);
  if ( !gpxFile.open(QIODevice::ReadOnly | QIODevice::Text) ) {
//Todo error must be shown in status on screen
    qDebug() << QString("Open gpx file %1: %2").arg(_gpxFilename).arg(gpxFile.errorString());
    return;
  }

  bool metaFound = false;
  bool trackFound = false;
  QXmlStreamReader xml (&gpxFile);
  while ( !xml.atEnd() && !xml.hasError() ) {
    QXmlStreamReader::TokenType token = xml.readNext();

    if ( token == QXmlStreamReader::StartDocument ) continue;

    if ( token == QXmlStreamReader::StartElement ) {
      //qDebug() << QString("Token: %1").arg(xml.name());
      if ( xml.name() == "metadata" ) {
        xml.readNext();
        this->_parseMetadata(xml);
        metaFound = true;
      }

      else if ( xml.name() == "trk" ) {
        xml.readNext();
        this->_parseTrackdata(xml);
        trackFound = true;
      }

      if ( metaFound && trackFound ) break;
    }
  }
}

// ----------------------------------------------------------------------------
// process metadata in gpx file
void GpxFile::_parseMetadata(QXmlStreamReader &xml) {
  while ( !( xml.tokenType() == QXmlStreamReader::EndElement &&
             xml.name() == "metadata"
           )
        ) {

    if ( xml.tokenType() == QXmlStreamReader::StartElement ) {
      //qDebug() << QString("Token: %1").arg(xml.name());
      if ( xml.name() == "description" ) {
        _gpxDescr = xml.readElementText();

        //qDebug() << _gpxDescr;

        break;
      }
    }

    xml.readNext();
  }
}

// ----------------------------------------------------------------------------
// process track data in gpx file to get name of the track
void GpxFile::_parseTrackdata(QXmlStreamReader &xml) {
  while ( !( xml.tokenType() == QXmlStreamReader::EndElement &&
             xml.name() == "trk"
           )
        ) {

    if ( xml.tokenType() == QXmlStreamReader::StartElement ) {
      //qDebug() << QString("Token: %1").arg(xml.name());
      if ( xml.name() == "name" ) {
        _trackName = xml.readElementText();

        //qDebug() << _trackName;

        break;
      }
    }

    xml.readNext();
  }
}
