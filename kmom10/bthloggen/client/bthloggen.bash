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

#
# Message to display for usage and help.
#
function usage {
    local txt=(
        "Utility $SCRIPT for doing stuff."
        "Usage: $SCRIPT [options] <command> [arguments]"
        ""
        "Command:"
        "  url            Get url to view the server in browser."
        "  view                List all entries."
        "  view url <url>      View all entries containing <url>."
        "  view ip <ip>        View all entries containing <ip>."
        "  use <server>        Set the servername (localhost or service name)."

        ""
        "Options:"
        "  --help, -h     Print help."
        "-v, --version   Display the current version"
        "-c, --count     Display the number of rows returned"
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
# Function to get url
#
function app-url {

    echo "Get url to view the server in browser"
}

#
# Function to view all entries
#
function app-view {

    echo "List all entries."
    echo "view all entries containing <url>"
    echo "view all entries containing <ip>"
}

#
# Function  Set the servername (localhost or service name).
#
function app-use {
    echo " Set the servername (localhost or service name)."
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
        usage
        exit 0
        ;;

    \
        --count | -c)
        usage
        exit 0
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
