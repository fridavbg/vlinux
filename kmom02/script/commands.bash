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
        "  cal [events]     Print out current calendar with(out) events."
        "  uptime           Show systems built-in uptime."
        "  greet            Greet the current user."
        "  loop <min> <max> Print numbers from min to max"
        "  lower Print all numbers lower than 42" 
        "  reverse Print all arguments in reverse order" 
        "  all Runs all functions" 
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
        "$SCRIPT --help, -h"
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
# Function for displaying a calender
#
function app-cal {
    echo "This is output from cal, showing a calender."
    cal
}

#
# Function for showing the systems built-in uptime
#
function app-uptime {
    echo "The system built in uptime is."
    uptime
}

#
# Function for greeting the current user
#
function app-greet {
    echo "Bienvenido a la programma de commandos,  "
    echo 
    whoami
}

#
# Function for looping from min to max
#
function app-loop {
    min=$1
    max=$2
    for (( i=min; i<=max; i++ ))
    do
            echo "$i"  
    done
}

#
# Function for looping a list of numbers 
# and only print lower than 42
#
function app-lower {
    for value in "$@"
    do
        if (( "$value" < 42))
        then
            echo "$value"
        fi  
    done
}

#
# Function for printing a sentence backwards
#
function app-reverse {
    echo "$*" | rev
}

#
# Function to run all functions
#
function app-all {
    echo
    app-cal
    echo 
    app-uptime
    echo
    app-greet
    echo 
    app-loop 1 4
    echo
    app-lower 34 56 32 12 11 2 3 4
    echo 
    app-reverse Hola como estas
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

        cal         \
        | uptime       \
        | greet         \
        | loop     \
        | lower \
        | reverse\
        | all)
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
