set -e # Exit if error
trap 'rm tmp nohup.out' EXIT # Delete temp files if error occurs

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Invalid arguments. Enter VM name, Zone, ProjectID"
	exit 1
fi

username=`gcloud config list account --format "value(core.account)" | cut -d @ -f 1`
echo "Y" | gcloud compute reset-windows-password $1 --user=$username --zone $2 --project $3 > tmp
password=`cat tmp | grep "password: " | tr -d '[:space:]' | cut -d : -f 2`
echo "**********************************************"
echo "The password is: $password"
echo "**********************************************"
rm tmp 2> /dev/null
nohup gcloud compute start-iap-tunnel $1 3389 --zone $2 --project $3 &
sleep 5
port=`cat nohup.out | grep "unused port" | cut -d [ -f 2 | sed 's/].//g'`
open -n -F -a /Applications/Microsoft\ Remote\ Desktop.app "rdp://full%20address=s:localhost:$port&username:s:$username&audiomode=i:0&disable%20themes=i:1&desktopwidth:i:$width&desktopheight:i:$height&prompt%20for%20credentials%20on%20client:i:0"
