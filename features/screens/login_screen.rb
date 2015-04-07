class LoginScreen < CommonScreen

  LOGIN_BUTTON = {
  	android: "android.widget.Button id:'login'",
  	ios: "UIButton id:'buttonLogin'"
  }

  USERNAME = {
  	android: "android.widget.EditText id:'username'",
  	ios: "UITextField id:'userInput'"
  }

  PASSWORD = {
  	android: "android.widget.EditText id:'password'",
  	ios: "UITextField id:'passwordInput'"
  }


  SCREEN_HEADER = {
	android: "android.widget.TextView id:'loginTitle'",
  	ios: "UIView id:'viewLogin'"
  }

def initialize 
	super SCREEN_HEADER
end


end