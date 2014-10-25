df -lh | awk '{print $1,$5,$4}' | column -t
