#!/bin/bash
now=$( date '+%F_%H:%M:%S' )
hourly=$( date '+%F_%H_%M_%S' )

testsite1=https://www.facebook.com/lamlamw1708
testsite2=https://playwright.dev/docs/intro#installing-playwright

echo "Capturing script on $now"
read -p "Do you want to start the automation capture now?: " reply
case $reply in
        N|n|No|no)
        echo "Automation was cancelled. Quitting..."
        ;;
        ""|Y|y|yes|Yes)
        echo "Capturing in process"
        echo "Step 1: mkdir for now"
                cd /c/Pictures/Screenshots/autocap
		mkdir SS_$hourly
	echo "Step 2: Capture the 1st site"
	node caplog.js $testsite1 s1_$hourly.png
	echo "Step 3: Capture the 2nd site"
	node caplog.js $testsite2 s2_$hourly.png
	echo "Step 4: Copy pics to the right folder."
	cp s1_$hourly.png /c/Pictures/Screenshots/autocap/SS_$hourly
	cp s2_$hourly.png /c/Pictures/Screenshots/autocap/SS_$hourly
	echo "Step 5: Done, please check folder."
        ;;
        *)
        echo "Invalid option. Quitting..."
        ;;
esac
