--passwordInput should have your password to your KAIST account. 
--Please replace 'thisistheplasswhereyouputyourpasswordin' with your password.
--I doubt it is a safe coding practice. Just did it for convenience's sake.



tell application "Safari"
	activate
	open location "https://klms.kaist.ac.kr"
	delay 0.5 -- Wait for the page to load
	open location "https://iam2.kaist.ac.kr/#/commonLogin?sso_type=S&param_id=aOdFpCn9KxI"
	delay 3.5
	do JavaScript "
        var inputs = document.querySelectorAll('input[type=\"submit\"]');
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].value === '비밀번호 인증') {
                inputs[i].click();
                break;
            }
        }
    " in document 1
	
	do JavaScript "
        var inputField = document.getElementById('passwordInput');
        inputField.value = 'thisistheplasswhereyouputyourpasswordin';
        var event = new Event('input', {
            'bubbles': true,
            'cancelable': true
        });
        inputField.dispatchEvent(event);
    " in document 1
	
	do JavaScript "document.querySelector('.loginbtn').click();" in document 1
	
	delay 0.5
	
	do JavaScript "
	    var emailInput = document.querySelectorAll('input[type=\"submit\"]');
	    for (var i = 0; i < emailInput.length; i++) {
	        if (emailInput[i].value.startsWith('외부 메일')) {
	            emailInput[i].click();
	            break;
	        }
	    }
	" in document 1
	
end tell
