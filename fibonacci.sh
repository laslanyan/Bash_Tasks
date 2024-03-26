#!/bin/bash

# Creating a fib function

fib() {
    if [ "$1" -le 1 ]; then
        echo "$1"
    else
        echo $(( $(fib $(($1-1))) + $(fib $(($1-2))) ))
    fi
}

# Ask the user for input

read -rp "Enter the value of n: " n

# Check if the input is numeric

if [[ $n =~ ^[0-9]+$ ]]; then
    result=$(fib "$n")
    echo "The $n-th Fibonacci number is: $result"
else
    echo "Invalid input. Please enter a non-negative integer."
fi
