#!/usr/bin/env bash
#
# A template for creating command line scripts taking options, commands
# and arguments.
#
# Exit values:
#  0 on success
#  1 on failure
#

#
# Check if DBWEBB_PORT is assigned
#
if [[ -n "$DBWEBB_PORT" ]]; then
    PORT=$DBWEBB_PORT
else
    PORT=8080
fi

# Base url with port
BASE_URL="http://localhost:${PORT}"

# Name of the script
SCRIPT=$(basename "$0")

# Current version
VERSION="1.0.0"

# SAVE flag
SAVE=false

#
# Message to display for usage and help.
#
function usage {
    local txt=(
        "Utility $SCRIPT for doing stuff."
        "Usage: $SCRIPT [options] <command> [arguments]"
        ""
        "Command:"
        "  init           Initialize a game. "
        "  maps           Show all map.      "
        "  select <#map>  Display map by #.  "
        "  enter          Move into 1st room."
        "  info           Display room info. "
        "  go north - If there is a northern room go there."
        "  go south - If there is a southern room go there."
        "  go east - If there is a eastern room go there."
        "  go west - If there is a western room go there."

        \
        ""
        "Options:"
        "  --help, -h     Print help."
        "  --version, -h  Print version."
        "  --save. -s     Save data in saved.data"
    )

    printf "%s\\n" "${txt[@]}"
}

#
# Message to display when bad usage.
#
function badUsage {
    local message="$1"
    local txt=(
        "For an overview of the command, execute:"
        "$SCRIPT --help"
    )

    [[ -n $message ]] && printf "%s\\n" "$message"

    printf "%s\\n" "${txt[@]}"
}

#
# Message to display for version.
#
function version {
    local txt=(
        "$SCRIPT version $VERSION"
    )

    printf "%s\\n" "${txt[@]}"
}

#
# Function to initialize game
#
function app-init {

    echo "Initiera ett spel och spara ned spelets id i en fil."
}

#
# Function to display available maps
#
function app-maps {
    echo "Visa vilka kartor som finns att välja bland."
}

#
# Function to display map by number
#
function app-select {
    echo "Välj en viss karta via siffra."
}

#
# Function to enter first room
#
function app-enter {
    echo "Gå in i första rummet."

}

#
# Function to display room info.
#
function app-info {
    echo "Visa information om rummet."
}

#
# Function to move to a new room
# If directions exists
#
function app-go {
    echo "Gå till ett nytt rum, om riktningen stödjs."
}

#
# Process options
#
while (($#)); do
    case "$1" in

    --help | -h)
        usage
        exit 0
        ;;

    --version | -v)
        version
        exit 0
        ;;

    --save | -s)
        SAVE=true
        shift
        ;;

    all | \
        init | \
        maps | \
        select | \
        enter | \
        info | \
        go)
        command=$1
        shift
        app-"$command" "$@"
        exit 0
        ;;

    *)
        badUsage "Option/command not recognized."
        exit 1
        ;;

    esac
done

badUsage
exit 1
