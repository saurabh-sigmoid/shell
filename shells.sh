#!/bin/bash

first_co=$1
second_re=$2
value_scale=$3
COUNT=$4
file=$5

Bidfn () { 
	LineNumber=$( cat $file | grep -i -n "$first_co" | grep -i -n "$VAR" | awk -F ":" '{print $2}' ) # conf
        if [[ $LineNumber -ne "NULL" ]]
        then

                conf=$( cat $file | grep -i  "$first_co" | grep -i  "$VAR"  )
                SCALE=$( echo $conf | awk -F ';' '{print $2}')
                SELECT_COUNT=$( echo $conf | awk -F '=' '{print $2}')
                new_conf=$( echo $conf | sed  "s/$SCALE/$value_scale/g"  )
                new_conf2=$( echo $new_conf | sed  "s/$SELECT_COUNT/$COUNT/g"  )
                sed -i "s/$conf/$new_conf2/g" $file
        else
                echo "Invalid bid entry."
        fi

}


Auctionfn () {
	
	LineNumber=$( cat $file | grep -i -n  "$first_co" | grep -i -n -v "$VAR" | awk -F ":" '{print $2}' ) 
    	conf=$( cat $file | grep -i  "$first_co" | grep -i -v "$VAR"  )
    	SCALE=$( echo $conf | awk -F ';' '{print $2}')                            
    	SELECT_COUNT=$( echo $conf | awk -F '=' '{print $2}')         
    	new_conf=$( echo $conf | sed  "s/$SCALE/$value_scale/g"  )

    	new_conf2=$( echo $new_conf | sed  "s/$SELECT_COUNT/$COUNT/g"  )
    	sed -i "s/$conf/$new_conf2/g" $file

}


VAR="bid"
if [[ "$second_re" =~ "Auction" ]]
then
        Auctionfn
elif [[ "$second_re" =~ "bid" ]]
then
        Bidfn
else    
        echo "Please type valid entry." 
fi
cat $file
