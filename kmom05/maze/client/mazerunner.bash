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
    PORT=1337
fi

# Base url with port
BASE_URL="http://localhost:${PORT}"

#CSV conversion
CSV="?type=csv"

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
    #SAVE ID
    url="$BASE_URL$CSV"
    curl -o game.csv -s "$url"
    while IFS="," read -r text gameid; do
        echo ""
        echo "$text"
        echo "GameId: $gameid"
        echo ""
    done < <(tail -n +2 game.csv)
}

#Game Id
ID=$(sed -n '2 p' game.csv | cut -d "," -f 2)

#
# Function to display available maps
#
function app-maps {

    url="$BASE_URL/map$CSV"
    curl -o maps.csv -s "$url"
    echo ""
    echo "Use mazerunner select # cmd to choose map"
    while IFS="," read -r big_maze small_maze; do
        echo ""
        echo "1: $big_maze"
        echo "2: $small_maze"
        echo ""
    done < <(tail -n +2 maps.csv)
}

#
# Function to select map by number
#
function app-select {
    url="$BASE_URL/$ID/map"

    if [ -z "$1" ]; then
        echo "No number was given"
        exit 1
    fi

    if [ "$1" == 1 ]; then
        echo ""
        echo $(curl "$url/small-maze$CSV" -s | head -n 2 | tail -1)
        echo "Small maze"
        echo ""
    elif [ "$1" == 2 ]; then
        echo ""
        curl "$url/maze-of-doom$CSV" -s | head -n 2 | tail -1
        echo "Maze of Doom"
        echo ""
    else
        echo ""
        echo "No map with that number"
        echo ""
    fi
}

#
# Function to enter first room
#
function app-enter {
    url="$BASE_URL/$ID/maze"

    echo
    curl "$url"
}

#
# Function to display room info.
#
function app-info {
    url="$BASE_URL/$ID/maze"

    echo
    curl "$url"
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
