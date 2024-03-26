#!/bin/bash

# Function to encrypt text using Caesar cipher

caesar_encrypt() {
    local shift="$1"
    tr "A-Za-z" "[${ALPHABET:shift}${ALPHABET:0:shift}]"
}

# Define the alphabet for reference

ALPHABET="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

# Parse command line arguments

while getopts ":s:i:o:" opt; do
    case $opt in
        s)
            shift_value="$OPTARG"
            ;;
        i)
            input_file="$OPTARG"
            ;;
        o)
            output_file="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# Check if required parameters are provided

if [ -z "$shift_value" ] || [ -z "$input_file" ] || [ -z "$output_file" ]; then
    echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
    exit 1
fi

# Check if input file exists

if [ ! -f "$input_file" ]; then
    echo "Input file '$input_file' not found."
    exit 1
fi

# Encrypt the content of the input file and write to the output file

caesar_encrypt "$shift_value" < "$input_file" > "$output_file"

echo "Encryption completed. Output written to $output_file"

# We can run our script and encrypt by using -s -i -o parameters 

