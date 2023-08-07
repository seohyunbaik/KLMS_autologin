--it should take the return value of the mail_work.applescript code and use it


on run {authCode}
	tell application "Safari"
		activate
		
		-- Paste the authentication code into the input field
		do JavaScript "
            var authInput = document.querySelector('input[type=\"password\"][placeholder=\"외부 메일 인증번호 입력\"]');
            authInput.value = '" & authCode & "';
            var event = new Event('input', {
                'bubbles': true,
                'cancelable': true
            });
            authInput.dispatchEvent(event);
        " in document 1
		
		-- Click the login button
		do JavaScript "document.querySelector('input[type=\"submit\"][value=\"로그인\"]').click();" in document 1
		open location "https://klms.kaist.ac.kr"
	end tell
end run
