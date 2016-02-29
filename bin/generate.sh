#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../data
files=$(ls ./*/*.txt)

for file in $files; do

  f=../export/$(echo ${file%.*} | awk -F'/' '{print $2" "$3 }')
  if [ ! -d "$f" ]; then
    mkdir "$f";
    for relId in `cat "$file" | awk '{print $1}'`;do
      if [ "$relId" != '#' ]; then
        wget -qO- http://polygons.openstreetmap.fr/index.py?id=$relId > ../export/$relId.status

        printf "# " > "$f/$relId.txt"
        wget -qO- http://www.openstreetmap.org/relation/$relId | grep \<title >> "$f/$relId.txt"

        echo "# This polygon is based on data © OpenStreetMap contributors" >> "$f/$relId.txt"
        echo "# The OpenStreetMap data is made available under the Open Database License, see http://www.openstreetmap.org/copyright" >> "$f/$relId.txt"
        echo "# This polygon file is made available under the same Open Database License: http://opendatacommons.org/licenses/odbl/1.0/." >> "$f/$relId.txt"
        echo "# relation Id: $relId" >> "$f/$relId.txt"
        echo >> "$f/$relId.txt"
        wget -qO- http://polygons.openstreetmap.fr/get_poly.py?id=$relId\&params=0 | grep -F . | awk '{$1=$1;print}' >> "$f/$relId.txt"
        echo >> "$f/$relId.txt"

        sed -i 's/$'"/`echo \\\r`/" "$f/$relId.txt"
        echo "$relId: done";
      fi
    done
  fi;
done

