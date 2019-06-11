# Version 1.1
# Copyright (c) 2019 pilisir.tw@gmail.com
# Under MIT Licesne, please go to "https://en.wikipedia.org/wiki/MIT_License" to check license terms.

set +H
itemsPathArray=()
lastItemPath=""
eachItemPathEscape=""

escapePath() {
	resultValue=$(echo "$@" | sed 's@[\]@\\\\@g;s/"/\\"/g;s/\ /\\ /g;s/'"'"'/\'"\'"'/g;s/`/\\`/g;s/:/\\:/g;s/?/\\?/g;s/!/\\!/g;s/</\\</g;s/>/\\>/g;s/|/\\|/g;s/*/\\*/g;s/(/\\(/g;s/)/\\)/g;s/\[/\\[/g;s/\]/\\]/g;s/{/\\{/g;s/}/\\}/g;s/&/\\&/g;s/%/\\%/g;s/\$/\\$/g;s/#/\\#/g;s/~/\\~/g;s/=/\\=/g;s/,/\\,/g;s@[;]@\\;@g;')
	echo $resultValue
}

targetFolder=$(osascript <<EOF
	tell application "Finder"
		activate
	    if exists Finder window 1 then
	        set currentDir to target of Finder window 1 as alias
	    else
	        set currentDir to desktop as alias
	    end if
	end tell
	tell application "System Events"
    	activate
		POSIX path of (choose folder with prompt "Please choose the folder of target:" ¬
	    	default location currentDir)
	end tell 	
EOF
)

if [ -z $targetFolder ]; then
	exit
fi

if [[ ${targetFolder: -1} == "/" && ${targetFolder} != "/" ]]; then
	targetFolder=\""${targetFolder%?}"\"
fi

while read -r eachItemPath;
do
	if [[ $targetFolder == *"$eachItemPath"* || $targetFolder == "${eachItemPath%/*}" ]]; then
		exit
	fi
	eachItemPathEscape=$(escapePath "$eachItemPath")
	itemsPathArray+=($eachItemPathEscape)
done

eachItemPathEscape=$(escapePath $targetFolder)
itemsPathArray+=($eachItemPathEscape)

{ 
	cmd="cp -R ${itemsPathArray[@]}"
	eval $cmd && echo OK
} || {
	# Dialog Title
	dialogTitle="Require password"

	# obtain the password from a dialog box
	authPass=$(osascript <<EOT
	tell application "System Events"
	    activate
	    repeat
	        display dialog "Action requires administrator privileges.\r\nPassword:" ¬
	            default answer "" ¬
	            with title "$dialogTitle" ¬
	            with hidden answer ¬
	            buttons {"Cancel", "Ok"} default button 2
	        if button returned of the result is "Cancel" then
	            return 1
	            exit repeat
	        else if the button returned of the result is "Ok" then
	            set pswd to text returned of the result
	            set usr to short user name of (system info)
	            try
	                do shell script "echo test" user name usr password pswd with administrator privileges
	                return pswd
	                exit repeat
	            end try
	        end if
	        end repeat
	        end tell
	EOT
	)

	# Abort if the Quit button was pressed
	if [ "$authPass" == 1 ]; then
	    echo "User Canceled. Exit"
	    exit 0
	fi

	cmd="echo $authPass | sudo -S cp -a ${itemsPathArray[@]}"
	eval $cmd
}