#!/usr/bin/env bash
#
# A template for creating command line scripts taking options, commands
# and arguments.
#
# Exit values:
#  0 on success
#  1 on failure
#

# Name of the script
SCRIPT=$(basename "$0")

# Current version
VERSION="1.0.0"

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
# Message to display for version.
#
function save {
    local txt=(
        "$SCRIPT version $VERSION"
    )

    printf "%s\\n" "${txt[@]}"
}

#
# Function for calling route /all
#
function app-all {

    echo
    curl http://localhost:1337/all

}

#
# Function for calling route /names
#
function app-names {
    echo
    curl http://localhost:1337/names
}

#
# Function for calling route /color/:color
#
function app-color {
    if [ -z "$1" ]; then
        echo "No color was given"
        exit 1
    fi

    echo
    curl http://localhost:1337/color/$1
}

#
# Function for test all routes
#
function app-test {
    if [ "$1" != 'color' ]; then
        curl http://localhost:1337/$1 -Is | head -n1 | cut -d" " -f3
    else
        curl http://localhost:1337/$1/$2 -Is | head -n1 | cut -d" " -f3
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
        save
        exit 0
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
