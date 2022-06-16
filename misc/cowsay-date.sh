date1="$(date -d "$(cat /var/db/repos/gentoo/metadata/timestamp)" +"%Y-%m-%d %H:%M:%S")"
date2="$(date +"%Y-%m-%d %H:%M:%S")"

D1=$(date -d "$date1" '+%s')
D2=$(date -d "$date2" '+%s')

days=$(((D2-D1)/86400))
hours=$(date -u -d @$((D2-D1)) +%H)
minutes=$(date -u -d @$((D2-D1)) +%M)

case $1 in
    "day")
        echo $days;;
    "hour")
        echo $hours;;
    "min")
        echo $minutes;;
esac
