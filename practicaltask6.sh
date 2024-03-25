#!/bin/bash

#  This script is used for generating a report file with following info. 

#  current date and time;
#  name of current user;
#  internal IP address and hostname;
#  external IP address;
#  name and version of Linux distribution;
#  system uptime;
#  information about used and free space in / in GB;
#  information about total and free RAM;
#  number and frequency of CPU cores

clear

echo ""

echo "Current date and time: $(date)"

echo ""

echo "==============================================================================="

echo ""

echo "Name of current user: $(whoami)"

echo ""

echo "==============================================================================="

echo ""

internal_ip=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')

hostname=$(hostname) 

echo "My internal IP address: $internal_ip"

echo "My hostname is: $hostname" 

echo ""

echo "==============================================================================="

echo ""

external_ip=$(curl -s https://api.ipify.org) 

echo "My external IP adress is: $external_ip"

echo ""

echo "==============================================================================="

echo ""

# Get macOS version
macos_version=$(sw_vers -productVersion)

# Get macOS name
macos_name=$(sw_vers -productName)

echo "macOS Name: $macos_name"
echo "macOS Version: $macos_version" 

echo ""

echo "==============================================================================="

echo ""

echo "My system uptime is: $(uptime)"

echo ""

echo "==============================================================================="

echo ""

# Run df command to get disk space usage
df_output=$(df -h /)

# Extract used and available space in GB
used_space=$(echo "$df_output" | awk 'NR==2 {print $3}')
available_space=$(echo "$df_output" | awk 'NR==2 {print $4}')

echo "Used space: $used_space"
echo "Available space: $available_space"

echo ""

echo "==============================================================================="

echo ""

# Display total and free RAM
total_ram=$(sysctl -n hw.memsize)
free_ram=$(vm_stat | awk '/free/ {print $3 * 4096}')

# Convert bytes to gigabytes for readability
total_ram_gb=$(echo "scale=2; $total_ram / 1024 / 1024 / 1024" | bc)
free_ram_gb=$(echo "scale=2; $free_ram / 1024 / 1024 / 1024" | bc)

echo "Total RAM: $total_ram_gb GB"
echo "Free RAM: $free_ram_gb GB"

echo ""

echo "==============================================================================="

echo ""

# Display number and frequency of CPU cores
num_cores=$(sysctl -n hw.physicalcpu)
cpu_freq=$(sysctl -n hw.cpufrequency)

# Convert CPU frequency to GHz
cpu_freq_ghz=$(echo "scale=2; $cpu_freq / 1000000000" | bc)

echo "Number of CPU cores: $num_cores"
echo "CPU frequency: $cpu_freq_ghz GHz"

echo ""

echo "==============================================================================="
