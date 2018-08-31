#include "gpxfile.h"

#include <QDebug>
#include <QFile>

// ----------------------------------------------------------------------------
GpxFile::GpxFile(QObject *parent) : QObject(parent) {}

// ----------------------------------------------------------------------------
QString GpxFile::gpxFilename() {

  return _gpxFilename;
}

// ----------------------------------------------------------------------------
QString GpxFile::name ( ) {

  return _name;
}

// ----------------------------------------------------------------------------
QString GpxFile::setGpxFilename( QString gpxPath, QString gpxFilename) {

  QString description;

//Todo filename must be tested
  _gpxFilename = gpxFilename;
  _gpxPath = gpxPath;

  QFile gpxFile (gpxPath + "/" + gpxFilename);
  if ( !gpxFile.open(QIODevice::ReadOnly | QIODevice::Text) ) {
//Todo error must be shown in status on screen
    qDebug() << QString("Open gpx file %1: %2").arg(_gpxFilename).arg(gpxFile.errorString());
    return "";
  }

  bool metaFound = false;
  bool trackFound = false;
  QXmlStreamReader xml(&gpxFile);
  while ( !xml.atEnd() && !xml.hasError() ) {
    QXmlStreamReader::TokenType token = xml.readNext();

    if ( token == QXmlStreamReader::StartDocument ) continue;

    if ( token == QXmlStreamReader::StartElement ) {
      if ( xml.name() == "metadata" ) {
        xml.readNext();
        description = _parseMetadata(xml);
        metaFound = true;
      }

      else if ( xml.name() == "trk" ) {
        xml.readNext();
        _parseTrackdata(xml);
        trackFound = true;
      }

      if ( metaFound && trackFound ) break;
    }
  }

  return description;
}

// ----------------------------------------------------------------------------
// process metadata in gpx file
QString GpxFile::_parseMetadata(QXmlStreamReader &xml) {

  QString description;

  while ( !( xml.tokenType() == QXmlStreamReader::EndElement &&
             xml.name() == "metadata"
           )
        ) {

    if ( xml.tokenType() == QXmlStreamReader::StartElement ) {
      if ( xml.name() == "description" ) {
        description = xml.readElementText();
        break;
      }
    }

    xml.readNext();
  }

  return description;
}

// ----------------------------------------------------------------------------
// process track data in gpx file to get name of the track
void GpxFile::_parseTrackdata(QXmlStreamReader &xml) {
  while ( !( xml.tokenType() == QXmlStreamReader::EndElement &&
             xml.name() == "trk"
           )
        ) {

    if ( xml.tokenType() == QXmlStreamReader::StartElement ) {
      if ( xml.name() == "name" ) {
        _name = xml.readElementText();
        break;
      }
    }

    xml.readNext();
  }
}
