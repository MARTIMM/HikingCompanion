//import QtQuick 2.11
//import QtQuick.Controls 2.2
import QtLocation 5.9
//import QtPositioning 5.11

// Source of the maps
Plugin {
  id: root

  name: "osm" // "mapboxgl" // "mapbox" // "esri" //
  //required: Plugin.AnyMappingFeatures | Plugin.AnyGeocodingFeatures
  locales: [ "nl_NL", "en_US"]

  // In script above select MapType.CustomMap
  // QtCreator must have ssl support!
  PluginParameter {
    name: "osm.mapping.custom.host"
    value: "https://a.tile.opentopomap.org/"
  }

  PluginParameter {
    name: "osm.mapping.custom.mapcopyright"
    value: "<a href='http://www.opentopomap.org/'>OpenTopoMap</a>"
  }

  PluginParameter {
    name: "osm.mapping.custom.datacopyright"
    value: "<a href='http://www.openstreetmap.com/'>OpenStreetMap</a>"
  }

  PluginParameter {
    name: "osm.mapping.providersrepository.disabled"
    value: true
  }

  /*
  // Copy all files from <qt install>/5.11.2/Src/qtlocation/src/plugins/geoservices/osm/providers/5.8/*
  // to qrc:Assets/Providers and add to resources file. Then the api key
  // can be added to the url strings for the thunderforest site.
  // In script above select MapType.TerrainMap
  PluginParameter {
    name: "osm.mapping.providersrepository.address"
    value: "qrc:Assets/Providers"
  }
*/
}

