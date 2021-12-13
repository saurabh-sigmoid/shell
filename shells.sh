#!/bin/bash
file=sig.conf
n=1
while read line;
do
echo $n")"$line
n=$((n+1))
done < $file
read -p "Select line number to edit \n  " line_number
if [[ ! $line_number =~ ^[0-9]+$ ]] ; then
    echo "Bad Input"
    exit 0
fi
line_number1=$line_number
line_number1+=p
selected_line=$(sed -n $line_number1 $file)
read current_view current_scale current_component_name ETL var5 <<< $selected_line
read x current_count <<< $var5
echo "view = $current_view scale =$current_scale component=$current_component_name  count=$current_count"
read -p "Enter your value for view  " view
read -p "Enter your value for scale  " scale
read -p "Enter your value for component  " component
read -p "Enter your value for count  " count
if [ -z "$view" ] || [ -z "$scale" ] || [ -z "$component" ] || [ -z "$count" ] 
then 
    echo 'Please enter an input' 
    exit 0 
fi
while ! [[ "$view" =~ ^Auction$|^Bid$ ]]; 
do
echo "The value of view has to be one of these"
echo " Auction"
echo " Bid"
read -p "please enter a valid value  " view
done
while ! [[ "$scale" =~ ^Mid$|^High$|^Low$ ]]; 
do
echo "The value of scale has to be one of these"
echo " Mid"
echo " High"
echo " Low"
read -p "please enter a valid value  " scale
done
while ! [[ "$component" =~ ^Injestor$|^Joiner$|^Wrangler$|^Validator$ ]]; 
do
echo "The value of view has to be one of these"
echo " Injestor"
echo " Joiner"
echo " Wrangler"
echo " Validator"
read -p "please enter a valid value  " component
done
while ! [[ "$count" =~ ^[0-9]{1}$ ]]; 
do
echo "The value of view should be a single digit integer"
read -p "please enter a valid value  " count
done
if [[ $view == "Bid" ]]; then
view="vdopiasample-bid"
else 
view="vdopiasample-Auction"
fi
new_line=$view";"$scale";"$component";"$ETL";"$x"="$count
line_number+=s
$(sed -i "$line_number/$selected_line/$new_line/" $file)
