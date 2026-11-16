#!/bin/bash
: 'Write a bash script. Use the script from Part 3. 
The colour designations are similar. The script runs
without parameters. The parameters are set in the 
configuration file before the script is running.'

source "$(dirname "$0")/colors.sh"
source "$(dirname "$0")/info.sh"

# Message: if "ipcalc" is not installed
if ! command -v ipcalc > /dev/null; then
    echo "ERROR: ipcalc is not installed. Run: sudo apt install ipcalc"
    exit 1
fi


# Make the variables in configuration.conf file usable
CONFIGURATION_FILE="$(dirname "$0")/configuration.conf"

if [[ -f "$CONFIGURATION_FILE" ]]; then
    source "$CONFIGURATION_FILE"
fi

# Default messages
column1_background_stick=${column1_background:-default}
column1_font_color_stick=${column1_font_color:-default}
column2_background_stick=${column2_background:-default}
column2_font_color_stick=${column2_font_color:-default}

# Default values
column1_background=${column1_background:-5}     # 5- purple
column1_font_color=${column1_font_color:-2}     # 2- red
column2_background=${column2_background:-3}     # 3- green
column2_font_color=${column2_font_color:-1}     # 1- white



# Parameter validation
for number in "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"; do
    if [[ ! "$number" =~ ^[1-6]$ ]]; then
        echo "ERROR: colour values must be numbers from 1 to 6."
        echo "Modify the configuration file and run the script again."
        exit 1
    fi
done

# The font and background colours of one column must not match.
if [ "$column1_background" -eq "$column1_font_color" ] || [ "$column2_background" -eq "$column2_font_color" ]; then
    echo "ERROR: The font and background colours of one column must not match."
    echo "Modify the configuration file and run the script again."
    exit 1
fi

# Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)
# Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)
# Parameter 3 is the background of the values (after the '=' sign)
# Parameter 4 is the font colour of the values (after the '=' sign)
NAME_BG=$(get_background "$column1_background")    
NAME_FG=$(get_font "$column1_font_color")    
VALUE_BG=$(get_background "$column2_background")   
VALUE_FG=$(get_font "$column2_font_color")  

print_information


# Color scheme
color_scheme() {
    case "$1" in
        1) echo "white" ;;
        2) echo "red" ;;
        3) echo "green" ;;
        4) echo "blue" ;;
        5) echo "purple" ;;
        6) echo "black" ;;
    esac
}

# Color description information
echo
echo "Column 1 background = $column1_background_stick ($(color_scheme "$column1_background"))"
echo "Column 1 font color = $column1_font_color_stick ($(color_scheme "$column1_font_color"))"
echo "Column 2 background = $column2_background_stick ($(color_scheme "$column2_background"))"
echo "Column 2 font color = $column2_font_color_stick ($(color_scheme "$column2_font_color"))"