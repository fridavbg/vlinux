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
        "  all             Call route /all."
        "  names           Call route /names."
        "  color [color]  Call route /color/:color."
        "  test [url]    Check if servers is running."
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
# Function for calling route /all
#
function app-all {

    url="$BASE_URL/all"
    if $SAVE; then
        curl -o saved.data -s "$url"
        echo ""
        echo "Data was saved."
        echo ""
    fi
    curl "$url"
}

#
# Function for calling route /names
#
function app-names {
    url="$BASE_URL/names"

    if $SAVE; then
        curl -o saved.data -s "$url"
        echo ""
        echo "Data was saved."
        echo ""
    fi

    echo
    curl "$url"
}

#
# Function for calling route /color/:color
#
function app-color {
    if [ -z "$1" ]; then
        echo "No color was given"
        exit 1
    fi

    url="$BASE_URL/color/$1"

    if $SAVE; then
        curl -o saved.data -s "$url"
        echo "Data was saved."
    fi

    echo
    curl "$url"
}

#
# Function for test all routes
#
function app-test {

    if [[ -n $1 ]]; then
        url=$1
    else
        url="$BASE_URL"
    fi

    if $SAVE; then
        curl -o saved.data "$url" -Is
        echo "Data was saved."
    fi

    if
        curl --output /dev/null --silent --head --fail "$url"
    then
        echo "$url is OK"
    else
        echo "$url is not OK"
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

    --save | -s)
        SAVE=true
        shift
        ;;

    all | \
        names | \
        color | \
        test)
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
