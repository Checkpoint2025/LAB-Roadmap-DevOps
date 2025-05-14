#!/bin/bash

echo "=== System Resource Summary ==="

# 1.Operating system
echo -e "\n--- OS Release ---"
cat /etc/os-release

# 2. Server Uptime

echo -e "\n--- Server Uptime ---"
uptime

# 3. Total CPU usage
echo -e "\n--- CPU Usage ---"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

# 4. Total memory usage
echo -e "\n--- Memory Usage ---"
free -m | awk 'NR==2{
    total=$2; used=$3; free=$4;
    printf "Total: %d MB\nUsed: %d MB\nFree: %d MB\nUsed: %.2f%%\n", total, used, free, used/total*100
}'

# 5. Total disk usage
echo -e "\n--- Disk Usage (/) ---"
df -h / | awk 'NR==2 {
    printf "Total: %s\nUsed: %s\nFree: %s\nUsed: %s\n", $2, $3, $4, $5
}'

# 6. Top 5 processes by CPU usage
echo -e "\n--- Top 5 Processes by CPU Usage ---"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# 7. Top 5 processes by Memory usage
echo -e "\n--- Top 5 Processes by Memory Usage ---"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6


