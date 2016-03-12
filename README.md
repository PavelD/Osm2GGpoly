# Osm2GGpoly

Script to generate polygons for [Geoget](http://geoget.ararat.cz/) from [OpenStreetMap](http://www.openstreetmap.org/) relations.

## How to use this script:
* Prepare data with list of relations
* * COUNTRY_ID should match the list in the generate.sh script
* * data/COUNTRY_ID/meta.ini - contains czech description of the final package (without COUNTRY_ID and license)
* * data/COUNTRY_ID/TAG_NAME.txt - file with the relation definition
* * * name of the file will be part of the used tag name in Geoget (ie. COUNTRY_ID/TAG_NAME.txt will generate 'COUNTRY_ID TAG_NAME' tag)
* * * lines starting with '# ' are comments
* * * other lines should have format OSM_RELATION_ID following with optional comment
* Run bin/generate.sh script

Ready to use installation packages are in export/polygons-LOWERCASE_COUNTRY_ID-VERSION.gip. Other genrated files should be silently ingored.

### additional info:
* Polygon genration is ignored when 'export/COUNTRY_ID TAG_NAME' folder exists.
* 'export/COUNTRY_ID TAG_NAME OSM_RELATION_NAME_OSM_RELATION_ID.html' files are from http://polygons.openstreetmap.fr/index.py?id=OSM_RELATION_ID; If there is issue with given relation (ie. not closed error should appear there)

## TODO

* Semi-automatic import of relations
* Detection of changes since last export
* Correct naming of polygons (corruently windows-1250 encoding is used)

State of current project: *beta*

