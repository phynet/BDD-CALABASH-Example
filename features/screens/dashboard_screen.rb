class DashboardScreen < CommonScreen
  SCREEN_HEADER = {
	android: "android.widget.TextView id:'loginTitle'",
  	ios: "UIView id:'viewLogin'"
  }

  TITLE_SCREEN = {
  	android: "*",
  	ios: "*"
  }

def initialize
   super SCREEN_HEADER
end

def check_screen(title)
   predicate_contains(TITLE_SCREEN,title) #método del módulo ios-helper
   sleep(5) #espera a que todas las animaciones terminen de ejecutarse
end

end