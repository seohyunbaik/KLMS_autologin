-- the code's return value is utilized by other code.

tell application "Mail"
	activate
	
	delay 4
	
	set initialCount to count of messages of inbox
	set newCount to initialCount
	
	repeat while newCount is initialCount
		check for new mail for every account
		delay 0.1
		set newCount to count of messages of inbox
	end repeat
	
	if (count of accounts) is greater than 0 and (count of messages of inbox) is greater than 0 then
		set theMessage to first message of inbox
		set theContent to content of theMessage
		
		-- Find the occurrence of the Korean authentication code
		set koreanPattern to "인증번호: "
		set codeStartKorean to (offset of koreanPattern in theContent) + (length of koreanPattern)
		set codeEndKorean to codeStartKorean + 5 -- assuming 6-digit code
		set authCodeKorean to rich text codeStartKorean thru codeEndKorean of theContent
		
		-- Find the occurrence of the English authentication code
		set englishPattern to "Auth. Code : "
		set codeStartEnglish to (offset of englishPattern in theContent) + (length of englishPattern)
		set codeEndEnglish to codeStartEnglish + 5 -- assuming 6-digit code
		set authCodeEnglish to rich text codeStartEnglish thru codeEndEnglish of theContent
		
		-- Check that the codes match, or report an error if not
		if authCodeKorean is authCodeEnglish then
			return authCodeKorean
			
		else
			display dialog "Error: Korean and English authentication codes do not match."
		end if
	else
		display dialog "No accounts or messages found in the inbox."
	end if
end tell
