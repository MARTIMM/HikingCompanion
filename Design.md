[TOC]

# Designing the application

```plantuml

Config *- ConfigData
ConfigData *- GpxManager
GpxManager *- GpxFiles
GpxFiles *- GpxFile

```
