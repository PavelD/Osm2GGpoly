#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../data
files=$(ls ./*/*.txt)

for file in $files; do

  fdir=$(echo ${file%.*} | awk -F'/' '{print $2" "$3 }')
  f=../export/$fdir
  if [ ! -d "$f" ]; then
    mkdir "$f";
    for relId in `cat "$file" | awk '{print $1}'`;do
      if [ "$relId" != '#' ]; then
        wget -qO- http://polygons.openstreetmap.fr/index.py?id=$relId > ../export/$relId.status

        nameOriginal=$(wget -qO- http://www.openstreetmap.org/relation/$relId | grep -A1 Key:name\? | grep browse-tag-v | awk -F'>|<' '{print $3}' | recode utf-8..html | sed 's/\&amp\;/\&/g' | recode html..utf-8 )
        name=$(echo $nameOriginal | iconv -f utf-8 -t ascii//translit | tr "\/" "--" )

        echo "#@$nameOriginal" > "$f/$relId.txt"
        echo "# This polygon is based on data © OpenStreetMap contributors" >> "$f/$relId.txt"
        echo "# The OpenStreetMap data is made available under the Open Database License, see http://www.openstreetmap.org/copyright" >> "$f/$relId.txt"
        echo "# This polygon file is made available under the same Open Database License: http://opendatacommons.org/licenses/odbl/1.0/." >> "$f/$relId.txt"
        echo "# relation Id: $relId" >> "$f/$relId.txt"
        echo >> "$f/$relId.txt"
        wget -qO- http://polygons.openstreetmap.fr/get_poly.py?id=$relId\&params=0 | grep -F . | awk '{$1=$1;print}' >> "$f/$relId.txt"
        echo >> "$f/$relId.txt"

        sed -i 's/$'"/`echo \\\r`/" "$f/$relId.txt"
        mv "$f/$relId.txt" "$f/${name}_$relId.txt"
        mv ../export/$relId.status "../export/$fdir ${name}_$relId.html"
        echo "$relId: $name done";
      fi
    done
  fi;
done

