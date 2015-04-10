class DashboardScreen < CommonScreen
  SCREEN_HEADER = {
	  android: "android.widget.TextView id:'tableTitle'",
  	ios: "UIView id:'viewDashboard'"
  }

  TITLE_SCREEN = {
  	android: "* {text CONTAINS 'Superheroes List'}",
  	ios: "* {text CONTAINS 'Superheroes List'}"
  }

def initialize
   super SCREEN_HEADER
end

def check_screen(title)
  sleep(5) #espera a que todas las animaciones terminen de ejecutarse
  predicate_contains(TITLE_SCREEN,title) #método del módulo ios-helper
end

end