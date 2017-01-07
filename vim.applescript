on run {input, parameters}
	try
		set filename to POSIX path of input
		set cmd to "clear;cd `dirname " & filename & "`;vim " & filename
	on error errMsg
		set filename to ""
		set cmd to "vim"
	end try
	tell application "iTerm"
		
		tell the current window
			
			create window with default profile
			
			tell the current session
				
				write text cmd
				
			end tell
			
		end tell
		
	end tell
	
end run
