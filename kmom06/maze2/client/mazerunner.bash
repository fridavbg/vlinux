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

# CSV conversion
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
# curl localhost:1337/
#
function app-init {

    url="$BASE_URL$CSV"

    curl -o game.csv "$url" -s

    while IFS="," read -r text gameid; do
        echo ""
        echo "$text"
        echo "GameId: $gameid"
        echo ""
    done < <(tail -n +2 game.csv)
}

#
# Function to display available maps
# curl localhost:1337/map
#
function app-maps {

    url="$BASE_URL/map$CSV"

    curl -o maps.csv -s "$url"

    echo ""
    echo "Use mazerunner select # cmd to choose map"

    while IFS="," read -r maze_of_doom small_maze; do
        echo ""
        echo "1: $maze_of_doom"
        echo "2: $small_maze"
        echo ""
    done < <(tail -n +2 maps.csv)
}

#
# Function to select map by number
# curl localhost:1337/:gameid/map/small-maze
#
function app-select {
    GAMEID=$(sed -n '2 p' game.csv | cut -d "," -f 2)
    url="$BASE_URL/$GAMEID/map"

    if [ -z "$1" ]; then
        echo "No number was given"
        exit 1
    fi

    while IFS="," read -r maze_of_doom small_maze; do
        if [ "$1" = 1 ]; then
            echo ""
            curl "$url/$maze_of_doom"
            echo ""
            echo "You entered the $maze_of_doom"
            echo ""
        elif [ "$1" == 2 ]; then
            echo ""
            curl "$url/$small_maze"
            echo ""
            echo "You entered the $small_maze"
            echo ""
        else
            echo ""
            echo "There is no map with that number"
            echo ""
        fi
    done < <(tail -n +2 maps.csv)
}

#
# Function to enter first room
# curl localhost:1337/:gameid/maze
#
function app-enter {
    GAMEID=$(sed -n '2 p' game.csv | cut -d "," -f 2)
    url="$BASE_URL/$GAMEID/maze$CSV"

    curl -o room.csv -s "$url"
    curl -o currentRoom.csv "$url" -s

    while IFS="," read -r roomid description west east south north; do
        echo ""
        echo "You have entered room: $roomid"
        echo "Room description: $description"
        echo "You can go west $west time(s)"
        echo "You can go east $east time(s)"
        echo "You can go south $south time(s)"
        echo "You can go north $north time(s)"
        echo ""
    done < <(tail -n +2 room.csv)
}

#ROOMID - inital value
# ROOMID=$(sed -n '2 p' room.csv | cut -d "," -f 1)

#
# Function to display room info.
# curl localhost:1337/:gameid/maze
#
function app-info {
    GAMEID=$(sed -n '2 p' game.csv | cut -d "," -f 2)
    ROOMID=$(sed -n '2 p' currentRoom.csv | cut -d "," -f 1)
    url="$BASE_URL/$GAMEID/maze/$ROOMID$CSV"
    curl -o currentRoom.csv "$url" -s

    while IFS="," read -r roomid description west east south north; do
        echo ""
        echo "RoomID: $roomid"
        echo "Description: $description"
        echo "Options to the west: $west"
        echo "Options to the east: $east"
        echo "Options to the south: $south"
        echo "Options to the north: $north"
        echo ""
    done < <(tail -n +2 currentRoom.csv)
}

#
# Function to move to a new room
# If directions exists
# curl localhost:1337/:gameid/maze/:direction
#
function app-go {
    GAMEID=$(sed -n '2 p' game.csv | cut -d "," -f 2)
    ROOMID=$(sed -n '2 p' currentRoom.csv | cut -d "," -f 1)
    url="$BASE_URL/$GAMEID/maze/$ROOMID/$1$CSV"

    if [ -z "$1" ]; then
        echo "No direction was given"
        exit 1
    elif [ "$1" == 'west' ] ||
        [ "$1" == 'east' ] ||
        [ "$1" == 'south' ] ||
        [ "$1" == 'north' ]; then
        curl -o currentRoom.csv -s "$url"
    else
        echo "Direction not allowed"
    fi

    while IFS="," read -r roomid description west east south north text; do
        if [ "$description" == 'You found the exit' ]; then
            echo ""
            echo "Congratulations!!"
            echo "$description"
            echo '' >game.csv 1>/dev/null
            echo '' >maps.csv 1>/dev/null
            echo '' >room.csv 1>/dev/null
            echo '' >currentRoom.csv 1>/dev/null
            exit 1
        else
            echo ""
            echo "You have entered room: $roomid"
            echo "Room description: $description"
            echo ""
            echo "You can go west $west time(s)"
            echo ""
            echo "You can go east $east time(s)"
            echo ""
            echo "You can go south $south time(s)"
            echo ""
            echo "You can go north $north time(s)"
            echo ""
        fi
    done < <(tail -n +2 currentRoom.csv)

}

function app-loop {
    app-init
    echo "--------"
    app-maps
    echo "--------"
    read -p "Which number do you choose: " number
    app-select $number
    app-enter
    while true; do
        read -p "What direcction do you want to go: " direcction
        if [direcction == "exit"]; then
            exit 1
        else
            app-go $direcction
        fi
    done
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
        go | \
        loop)
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
