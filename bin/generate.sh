#!/bin/bash
scriptversion="2.1";
fullversion=${scriptversion}.`date +'%y%m%d%H%M'`;
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd "$DIR/../data";
files=$(ls ./*/*.txt);

declare -A c;

c=([US]="United States" [AF]="Afghanistan" [AX]="Aland Islands" [AL]="Albania" [DZ]="Algeria" [AS]="American Samoa" [AD]="Andorra"
   [AO]="Angola" [AI]="Anguilla" [AQ]="Antarctica" [AG]="Antigua and Barbuda" [AR]="Argentina" [AM]="Armenia" [AW]="Aruba"
   [AU]="Australia" [AT]="Austria" [AZ]="Azerbaijan" [BS]="Bahamas" [BH]="Bahrain" [BD]="Bangladesh" [BB]="Barbados" [BY]="Belarus"
   [BE]="Belgium" [BZ]="Belize" [BJ]="Benin" [BM]="Bermuda" [BT]="Bhutan" [BO]="Bolivia" [BQ]="Bonaire" [BA]="Bosnia and Herzegovina"
   [BW]="Botswana" [BV]="Bouvet Island" [BR]="Brazil" [IO]="British Indian Ocean Territories" [VG]="British Virgin Islands"
   [BN]="Brunei" [BG]="Bulgaria" [BF]="Burkina Faso" [BI]="Burundi" [KH]="Cambodia" [CM]="Cameroon" [CA]="Canada" [CV]="Cape Verde"
   [KY]="Cayman Islands" [CF]="Central African Republic" [TD]="Chad" [CL]="Chile" [CN]="China" [CX]="Christmas Island"
   [CC]="Cocos (Keeling) Islands" [CO]="Colombia" [KM]="Comoros" [CG]="Congo" [CK]="Cook Islands" [CR]="Costa Rica" [HR]="Croatia"
   [CU]="Cuba" [CW]="Curacao" [CY]="Cyprus" [CZ]="Czech Republic" [CD]="Democratic Republic of the Congo" [DK]="Denmark"
   [DJ]="Djibouti" [DM]="Dominica" [DO]="Dominican Republic" [TL]="East Timor" [EC]="Ecuador" [EG]="Egypt" [SV]="El Salvador"
   [GQ]="Equatorial Guinea" [ER]="Eritrea" [EE]="Estonia" [ET]="Ethiopia" [FK]="Falkland Islands" [FO]="Faroe Islands" [FJ]="Fiji"
   [FI]="Finland" [FR]="France" [GF]="French Guiana" [PF]="French Polynesia" [TF]="French Southern Territories" [GA]="Gabon"
   [GM]="Gambia" [GE]="Georgia" [DE]="Germany" [GH]="Ghana" [GI]="Gibraltar" [GR]="Greece" [GL]="Greenland" [GD]="Grenada"
   [GP]="Guadeloupe" [GU]="Guam" [GT]="Guatemala" [GG]="Guernsey" [GN]="Guinea" [GW]="Guinea-Bissau" [GY]="Guyana" [HT]="Haiti"
   [HM]="Heard Island And Mcdonald Islands" [HN]="Honduras" [HK]="Hong Kong" [HU]="Hungary" [IS]="Iceland" [IN]="India"
   [ID]="Indonesia" [IR]="Iran" [IQ]="Iraq" [IE]="Ireland" [IM]="Isle of Man" [IL]="Israel" [IT]="Italy" [CI]="Ivory Coast"
   [JM]="Jamaica" [JP]="Japan" [JE]="Jersey" [JO]="Jordan" [KZ]="Kazakhstan" [KE]="Kenya" [KI]="Kiribati" [KW]="Kuwait"
   [KG]="Kyrgyzstan" [LA]="Laos" [LV]="Latvia" [LB]="Lebanon" [LS]="Lesotho" [LR]="Liberia" [LY]="Libya" [LI]="Liechtenstein"
   [LT]="Lithuania" [LU]="Luxembourg" [MO]="Macau" [MK]="Macedonia" [MG]="Madagascar" [MW]="Malawi" [MY]="Malaysia" [MV]="Maldives"
   [ML]="Mali" [MT]="Malta" [MH]="Marshall Islands" [MQ]="Martinique" [MR]="Mauritania" [MU]="Mauritius" [YT]="Mayotte"
   [MX]="Mexico" [FM]="Micronesia" [MD]="Moldova" [MC]="Monaco" [MN]="Mongolia" [ME]="Montenegro" [MS]="Montserrat" [MA]="Morocco"
   [MZ]="Mozambique" [MM]="Myanmar" [NA]="Namibia" [NR]="Nauru" [NP]="Nepal" [NL]="Netherlands" [NC]="New Caledonia"
   [NZ]="New Zealand" [NI]="Nicaragua" [NE]="Niger" [NG]="Nigeria" [NU]="Niue" [NF]="Norfolk Island" [MP]="Northern Mariana Islands"
   [NO]="Norway" [OM]="Oman" [PK]="Pakistan" [PW]="Palau" [PS]="Palestine" [PA]="Panama" [PG]="Papua New Guinea" [PY]="Paraguay"
   [PE]="Peru" [PH]="Philippines" [PN]="Pitcairn Islands" [PL]="Poland" [PT]="Portugal" [PR]="Puerto Rico" [QA]="Qatar"
   [RE]="Reunion" [RO]="Romania" [RU]="Russia" [RW]="Rwanda" ["BQ-SA"]="Saba" [SH]="Saint Helena" [KN]="Saint Kitts and Nevis"
   [LC]="Saint Lucia" [WS]="Samoa" [SM]="San Marino" [ST]="Sao Tome and Principe" [SA]="Saudi Arabia" [SN]="Senegal" [RS]="Serbia"
   [SC]="Seychelles" [SL]="Sierra Leone" [SG]="Singapore" [SK]="Slovakia" [SI]="Slovenia" [SB]="Solomon Islands" [SO]="Somalia"
   [ZA]="South Africa" [GS]="South Georgia and Sandwich Islands" [KR]="South Korea" [SS]="South Sudan" [ES]="Spain" [LK]="Sri Lanka"
   [BL]="St Barthelemy" ["BQ-SE"]="St Eustatius" [PM]="St Pierre Miquelon" [VC]="St Vince Grenadines" [MF]="St. Martin" [SD]="Sudan"
   [SR]="Suriname" [SJ]="Svalbard and Jan Mayen" [SZ]="Swaziland" [SE]="Sweden" [CH]="Switzerland" [SY]="Syria" [TW]="Taiwan"
   [TJ]="Tajikistan" [TZ]="Tanzania" [TH]="Thailand" [TG]="Togo" [TK]="Tokelau" [TO]="Tonga" [TT]="Trinidad and Tobago"
   [TN]="Tunisia" [TR]="Turkey" [TM]="Turkmenistan" [TC]="Turks and Caicos Islands" [TV]="Tuvalu" [UG]="Uganda" [UA]="Ukraine"
   [AE]="United Arab Emirates" [GB]="United Kingdom" [UY]="Uruguay" [UM]="US Minor Outlying Islands" [VI]="US Virgin Islands"
   [UZ]="Uzbekistan" [VU]="Vanuatu" [VA]="Vatican City State" [VE]="Venezuela" [VN]="Vietnam" [WF]="Wallis And Futuna Islands"
   [EH]="Western Sahara" [YE]="Yemen" [ZM]="Zambia" [ZW]="Zimbabwe" );

for file in $files; do

  fdir=$(echo ${file%.*} | awk -F'/' '{print $2" "$3 }');
  f=../export/$fdir;
  if [ ! -d "$f" ]; then
    mkdir "$f";
    for relId in `awk '{print $1}' "$file"`; do
      if [ "$relId" != '#' ]; then
        wget -qO- http://polygons.openstreetmap.fr/index.py?id=$relId > ../export/$relId.status;

        wget -qO- http://www.openstreetmap.org/relation/$relId > "$f/$relId.txt";
        nameOriginal=$(grep -A1 Key:name\? "$f/$relId.txt" | grep browse-tag-v | awk -F'>|<' '{print $3}' | recode utf-8..html | sed 's/\&amp\;/\&/g' | recode html..utf-8 );
        name=$(echo $nameOriginal | iconv -f utf-8 -t ascii//translit | tr "\/" "--" );
        changeset=$(grep changeset/ "$f/$relId.txt" | awk -F'>|<' '{print $3}');

        echo "#@$nameOriginal" | iconv -f utf-8 -t windows-1252//translit > "$f/$relId.txt";
        echo "# This polygon is based on data © OpenStreetMap contributors" |  iconv -f utf-8 -t windows-1252//translit >> "$f/$relId.txt";
        echo "# The OpenStreetMap data is made available under the Open Database License, see http://www.openstreetmap.org/copyright" >> "$f/$relId.txt";
        echo "# This polygon file is made available under the same Open Database License: http://opendatacommons.org/licenses/odbl/1.0/." >> "$f/$relId.txt";
        echo "# relation Id: $relId; changeset: $changeset" >> "$f/$relId.txt";
        echo >> "$f/$relId.txt";
        wget -qO- http://polygons.openstreetmap.fr/get_poly.py?id=$relId\&params=0 | grep -F . | awk '{$1=$1;print}' >> "$f/$relId.txt";
        echo >> "$f/$relId.txt";

        sed -i 's/$'"/`echo \\\r`/" "$f/${relId}.txt";
        mv "$f/${relId}.txt" "$f/${name}_$relId.txt";
        mv ../export/$relId.status "../export/$fdir ${name}_$relId.html";
        echo "$relId: $name done";
      fi;
    done;
  fi;
  D=$(echo ${fdir% *});
  d=$(echo ${fdir% *} | awk '{print tolower($0)}');
  t=$(echo ${file%.*} | awk -F'/' '{print  tolower($3)}');

  #create structure for distribution package
  if [ ! -d "../export/polygons-${d}/divide/ini" ]; then
    mkdir -p "../export/polygons-${d}/divide/ini";
    mkdir -p "../export/polygons-${d}/divide/poly";
  fi;
  #add ini file for the country
  if [ ! -f "../export/polygons-${d}/divide/ini/${d}-${t}.ini" ]; then
    echo "[PolyDivider]" > "../export/polygons-${d}/divide/ini/${d}-${t}.ini";
    echo "Country=${c[$D]}" >> "../export/polygons-${d}/divide/ini/${d}-${t}.ini";
    echo "State=*" >> "../export/polygons-${d}/divide/ini/${d}-${t}.ini";
    echo "Polygons=$fdir" >> "../export/polygons-${d}/divide/ini/${d}-${t}.ini";
    echo "Tag=$fdir" >> "../export/polygons-${d}/divide/ini/${d}-${t}.ini";
    sed -i 's/$'"/`echo \\\r`/" "../export/polygons-${d}/divide/ini/${d}-${t}.ini";
  fi;
  # add installation script template
  if [ ! -f "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas" ]; then
    echo "//fnc-install" > "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "//fnc-uninstall" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "function InstallWork: String;" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "begin" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "  Result := '';" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "  //tagy-install" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "end;" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "function UninstallWork: String;" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "begin" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "  Result := '';" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "  //tagy-uninstall" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "end;" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    echo "# unix" >> "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
  fi;
  # add (un)install function for each polygon group
  if ! grep --quiet AddPolygon_${d}_${t} "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas"; then
    sed -i "/\/\/tagy-install/a\ \ AddPolygon_${d}_${t};" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/tagy-uninstall/a\ \ RemovePolygon_${d}_${t};" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a end;" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a\ \ RenameFile(Geoget_datadir + '\\\\script\\\\divide\\\\poly\\\\${fdir}', Geoget_datadir + '\\\\polygon\\\\${fdir}');" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a\ \ Deltree(Geoget_datadir + '\\\\polygon\\\\${fdir}\\\\');" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a\ \ \/\/odstran stare polygony a nakopiruj nove" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a\ \ DelTagCategory('${fdir}');" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a\ \ \/\/zrusit stare tagy (rezerva do budoucna)" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a\ \ Result := '';" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a begin" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-install/a function  AddPolygon_${d}_${t}: String;" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";

    sed -i "/\/\/fnc-uninstall/a end;" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-uninstall/a\ \ Deletefile(Geoget_datadir + '\\\\script\\\\divide\\\\ini\\\\${d}-${t}.ini.old');" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-uninstall/a\ \ Deletefile(Geoget_datadir + '\\\\script\\\\divide\\\\ini\\\\${d}-${t}.ini');" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-uninstall/a\ \ Deltree(Geoget_datadir + '\\\\polygon\\\\${fdir}\\\\');" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-uninstall/a\ \ Result := '';" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-uninstall/a begin" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
    sed -i "/\/\/fnc-uninstall/a function RemovePolygon_${d}_${t}: String;" "../export/polygons-${d}/divide/poly/polygons-${d}.ggi.pas";
  fi;

  cp -r "$f" "../export/polygons-${d}/divide/poly/";

  # add meta ini file
  if [ ! -f "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini" ]; then
    echo "[info]" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "description=${c[$D]} (${D}) polygons [CC-BY-SA]" | iconv -f utf-8 -t windows-1252//translit >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    cat "$D/meta.ini" | tr -d '\n' | iconv -f utf-8 -t windows-1252//translit >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo " (${D}) [CC-BY-SA]" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    # @TODO more than only one description
    echo "version=${fullversion}" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "ggversion=2.7.2" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "[install]" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "script=divide\\poly\\polygons-${d}.ggi.pas" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "[dependency]" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "[uninstall]" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    echo "divide\\poly\\polygons-${d}.ggi.pas=" >> "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
    sed -i 's/$'"/`echo \\\r`/" "../export/polygons-${d}/divide/poly/polygons-${d}.meta.ini";
  fi;
done;

# fix line endings in installation file
for dosFile in `grep ../export/polygons-*/divide/poly/polygons-*.ggi.pas -e "# unix"|tr " " "_"`; do
  sed -i 's/$'"/`echo \\\r`/" "${dosFile%:*}";
  sed -i '/# unix/d' "${dosFile%:*}";
done

# wrap package for Geoget
for divideDir in `find ../export/polygons-*/ -type d -name divide`; do
  cd "$divideDir/..";
  dirPwd=`pwd`
  echo "Create gip package for ${dirPwd##*/}"
  zip -9r ./${dirPwd##*/}-${fullversion}.gip ./divide/* 2>&1 >/dev/null
  cd "$DIR";
done

cd "$DIR";

