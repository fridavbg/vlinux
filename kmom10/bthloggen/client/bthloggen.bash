#!/usr/bin/env bash
#
# A template for creating command line scripts taking options, commands
# and arguments.
#
# Exit values:
#  0 on success
#  1 on failure
#

# Current version
VERSION="1.0.0"

# COUNT flag
COUNT=false

#
# Check if PORT is assigned
#
if [[ -n "$DBWEBB_PORT" ]]; then
    PORT=$DBWEBB_PORT
else
    PORT=1337
fi

# Server
SERVER_FILE="server.txt"
SERVER=$(cat "$SERVER_FILE")
# Base url with port
BASE_URL="http://${SERVER}:${PORT}"

#
# Message to display for usage and help.
#
function usage {
    local txt=(
        "Utility $SCRIPT for doing stuff."
        "Usage: $SCRIPT [options] <command> [arguments]"
        ""
        "Command:"
        "  url                 Get url to view the server in browser."
        "  view                List all entries."
        "  view url <url>      View all entries containing <url>."
        "  view ip <ip>        View all entries containing <ip>."
        "  use <server>        Set the servername (localhost or service name)."

        ""
        "Options:"
        "  --help, -h       Print help."
        "  --version, -v    Display the current version"
        "  --count, -c      Display the number of rows returned"
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
# Function to get url
#
function app-url {
    echo "Url to view server in browser is :"
    echo "$BASE_URL"
}

#
# Function to view all entries
# OR if url specific <url>
# OR if ip specific <ip>
#
function app-view {
    url="$BASE_URL/data"
    if [ -z "$1" ]; then
        if $COUNT; then
            curl "$url" -s | grep -o "}" | wc -l
            exit 0
        else
            echo "Available urls & ip addresses: "
            curl "$url" -s | jq
        fi
    elif [ "$1" == 'url' ]; then
        if [ -z "$2" ]; then
            echo "No url was given"
        else
            if $COUNT; then
                echo "Total number of lines: "
                curl "${url}?url=${2}" -s | grep -o "}" | wc -l 
            else
                curl "${url}?url=${2}" -s | jq
            fi
        fi
    elif [ "$1" == 'ip' ]; then
        if [ -z "$2" ]; then
            echo "No ip was given"
        else
            if $COUNT; then
                echo "Total number of lines: "
                curl "${url}?ip=${2}" -s | grep -o "}" | wc -l 
            else
                curl "${url}?ip=${2}" -s | jq
            fi
        fi
    else
        echo "Invalid command"
    fi
}

#
# Function set the servername (localhost or service name).
#
function app-use {
    if [[ "$1" == "localhost" || "$1" == "bthloggen-server" ]]; then
        echo ""
        echo "$1" >"$SERVER_FILE"
        echo "New server is: "
        echo "$1"
        echo ""
    else
        echo ""
        echo "Only servers available are "
        echo "bthloggen-server"
        echo "OR"
        echo "localhost"
        echo ""
    fi
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

    --count | -c)
        COUNT=true
        shift
        ;;

    url | \
        view | \
        use)
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
