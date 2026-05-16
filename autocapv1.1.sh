#autocap interactive improvement
#!/bin/bash

#save default variable
now=$( date '+%F_%H:%M:%S' )
hourly=$( date '+%F_%H_%M_%S' )
default_path=/c/Pictures/Screenshots/autocap
echo "Screenshots can be found in default path $default_path"

#Setting
echo "Autocap is now open at $now. Please choose your setting before starting (or press Ctrl+C to cancel automation)."
read -p "Do you want to start with default setting?(y/n): " answer
case $answer in
""|Y|y|yes|Yes)
	testsite1=https://nodejs.org/en/download
	testsite2=https://playwright.dev/docs/intro#installing-playwright
	echo "Site $testsite1 will be captured."
	echo "Site $testsite2 will be captured."
        echo "Capturing in process..."
        echo "Step 1: mkdir for now"
                cd $default_path
	echo "Screenshots can be found in $pwd with $hourly in name"
		mkdir SS_$hourly
	echo "Step 2: Capture the 1st site"
	node cap.js $testsite1 s1_$hourly.png
	echo "Step 3: Capture the 2nd site"
	node cap.js $testsite2 s2_$hourly.png
        echo "Step 4: Copy pics to the right folder."
	cp s1_$hourly.png /c/Pictures/Screenshots/autocap/SS_$hourly
	cp s2_$hourly.png /c/Pictures/Screenshots/autocap/SS_$hourly
	echo "Step 5: Done, please check folder."
	;;
N|n|No|no)
	sites=()
	count=1
	while true
	do
    	read -p "Please enter URL $count (type Done to stop): " site

    		case "$site" in
        	Done)
            	break
            	;;
       		*)
            	sites+=("$site")
            	((count++))
            	;;
    		esac
	done

if [[ ${#sites[@]} -eq 0 ]]; then
    echo "No sites were entered. Quitting..."
    exit 1
fi

echo "You entered ${#sites[@]} site(s):"
for site in "${sites[@]}"
do
    echo "$site"
done

#Make directory
echo "mkdir for now"
cd $default_path
echo "Screenshots can be found in $pwd with $hourly in name"
mkdir -p SS_$hourly
#login
read -p "Do your sites need login/authentication?(y/n): " reply
	case $reply in
	N|n|No|no)
	echo "The autocap process is starting:..."
	i=0
	for site in "${sites[@]}"
	do
	i=$((i+1))
	node cap.js "$site" "s${i}_${hourly}.png"
	cp "s${i}_${hourly}.png" "/c/Pictures/Screenshots/autocap/SS_$hourly"
	echo "Site $site was capped."
	done
	;;
	""|Y|y|yes|Yes)
	echo "Please login to continue..."
	echo "Before login node"
	node loginsetup.js
	echo "After login node:"
	echo "The autocap process is starting..."
	i=0
	for site in "${sites[@]}"
	do
	i=$((i+1))
	node caplog.js "$site" "s${i}_${hourly}.png"
	cp "s${i}_${hourly}.png" "/c/Pictures/Screenshots/autocap/SS_$hourly"
	echo "Site $site was capped."
	done       
	;;
	*)
	echo "Invalid option. Exitting..."
	;;
	esac
;;
*)
echo "Invalid option. Quitting..."
;;
esac

