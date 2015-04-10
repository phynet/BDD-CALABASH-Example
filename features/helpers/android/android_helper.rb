require 'calabash-android/operations'
include Calabash::Android::Operations
module AndroidHelper

	PLATFORM = :android

  def who_i_am
    PLATFORM
  end

  # General

  def hide_keyboard
    p "HIDE KEYBOARD"
    press_back_button
  end

  def open_app
    p "Opening app..."
    start_test_server_in_background
  end

  # Check elements exist

  def check_element(selector, force_view=true)
    p "Checking #{selector[PLATFORM]}"
    found = element_exists("#{selector[PLATFORM]}")
    p "Found!!!" if found
    p "Not found!" unless found
    return found
  end

  def check_element_with_text(selector,text)
    element_exists("#{selector[PLATFORM]} label marked:'#{text}'")
  end

  def check_with_timeout(selector, timeout=10)
    while timeout > 0
      return true if element_exists("#{selector[PLATFORM]}")
      trace_sleep(1)
      timeout -= 1
    end
    return false 
  end

  def predicate_contains(selector,value)
     element_exists("#{selector[PLATFORM]} {text CONTAINS '#{value}'}")
  end

  def get_text(selector,value)
    wait(selector)   
    element_exists("#{selector[PLATFORM]} text:'#{value}'")
  end

  def get_with_text(selector,value)
    query("#{selector} text:'#{value}'",:text)[0]
  end

  def get_first_text(selector)
     query("#{selector[PLATFORM]}'",:text)[0]
  end
  # Wait for elements

  def wait_screen_title(selector, title, time=20)
    wait_for_message(selector, title, time)
  end

  def wait_for_message(selector, msg, time=10)
    wait_for_elements_exist(["#{selector[PLATFORM]} marked:'#{msg}'" ], :timeout=>time.to_i)
  end

  def wait_for_message_predicate(selector, msg, time=10)
    wait_for_elements_exist(["#{selector[PLATFORM]} {text CONTAINS '#{msg}'}" ], :timeout=>time.to_i)
  end

  def wait_for_any_message(selector, messages, timeout=20)
    while timeout > 0
      messages.each do |msg|
        return true if element_exists("#{selector[PLATFORM]} marked:'#{msg}'")
      end
      trace_sleep(1)
      timeout -= 1
    end
    fail("Timeout reached in wait_for_any_message #{messages}")
  end

  def wait_while_exists(selector, time=40)
    wait_for_elements_do_not_exist(["#{selector[PLATFORM]}"], timeout: time.to_i)
  end

  # Tap on elements

	def tap_in(selector, time=20, force_view=false)
    wait(selector, time, force_view)
    p 'tap'
    p selector[PLATFORM]
    p touch("#{selector[PLATFORM]}")
	end

	def tap_in_cell_row(selector, position, time=20)
    wait(selector)
    touch("#{selector[PLATFORM]} index:#{position.to_i}")
  end

  def tap_in_ui_component_marked(selector,value)
    wait(selector)
    trace_sleep(1)
    touch("#{selector[PLATFORM]} marked:'#{value}'")
  end

  def tap_component_index(selector, index)
    wait(selector)
    touch("#{selector[PLATFORM]} index:#{index}")
  end
  # Fill inputs

  def fill(selector, value, force_type=false)
    wait(selector)
    enter_text("#{selector[PLATFORM]}",value)
  end

  # Scroll

  def scroll_to_element(scroll_selector, selector)
    until check_element(selector)
      scroll_down_selector
    end
  end

  def scroll_to_element_with_text(scroll_selector, selector, text)
    until check_element_with_text(selector,text)
      scroll_down_selector
    end
  end

  def scroll_to_cell_number(selector, section)
    scroll_to_row("#{selector[PLATFORM]}", section.to_i)
    trace_sleep(1)
  end

  def scroll_to_top(selector)
    scroll_to_row("#{selector[PLATFORM]}", 0)
    trace_sleep(1)
  end

  def scroll_down_selector(selector=nil)
    performAction('scroll_down') if android_calabash_version.eql? constants['CALABASH_VERSION']
    scroll_down unless android_calabash_version.eql? constants['CALABASH_VERSION']
  end

  def scroll_up_selector(selector=nil)
    performAction('scroll_up') if android_calabash_version.eql? constants['CALABASH_VERSION']
    scroll_up unless android_calabash_version.eql? constants['CALABASH_VERSION']
  end

  def scroll_to_row_number(selector, index)
    scroll_to_row("#{selector[PLATFORM]}",index)
  end

  # Swipe

  def swipe_right_screen
    performAction('drag', 75, 25, 50, 50, 5) if android_calabash_version.eql? constants['CALABASH_VERSION']
    perform_action('drag', 75, 25, 50, 50, 5) unless android_calabash_version.eql? constants['CALABASH_VERSION']
    #perform_action('swipe', 'right')
    trace_sleep(1)
  end

  def swipe_left_screen
    #perform_action('drag_coordinates', fromX, fromY, toX, toY)
    #usamos este perform_action('drag', fromX, toX, fromY, toY, steps)
    performAction('drag', 25, 75, 50, 50, 5) if android_calabash_version.eql? constants['CALABASH_VERSION']
    perform_action('drag', 25, 75, 50, 50, 5) unless android_calabash_version.eql? constants['CALABASH_VERSION']
    #perform_action('swipe', 'left')
    trace_sleep(1)
  end

  # Switchs

  def switch_is_checked_on(selector)
    query("#{selector[PLATFORM]}",:isChecked)[0]
  end

  def switch_status(selector, status)
    if status #on 
      tap_in(selector)  unless switch_is_checked_on(selector)
    else #off
      tap_in(selector)  if switch_is_checked_on(selector)
    end
  end

  # Date pickers

  def picker_date(selector, day, month, year)
    date =  DateTime.now
    wait(selector)

    if(month > date.month || year > date.year)
      touch("android.widget.Button id:'calendar_right_arrow'")
      touch("#{selector[PLATFORM]} text:'#{day}'")
    else
       touch("#{selector[PLATFORM]} text:'#{day}'")
    end
      touch("android.widget.Button id:'closeButton'")
  end

  def picker_table(selector, index)
    touch("#{selector[PLATFORM]} index:#{index}")
  end

  # Tables

  def count_cells(selector)
    @cant_index = query("selector[PLATFORM]", :count).first
  end

  def count_cells_table(selector)
    query("#{selector[PLATFORM]}").count
    puts "Count: #{value}"
  end

  def get_value(selector, index=0)
    query("#{selector[PLATFORM]}", :text)[index]
  end

  def get_cells_text(selector, section=nil)
    get_values_table(selector,:description)
  end

  def set_query_for_all(selector,type)

    aux_text = query("#{selector[PLATFORM][:description]}", :text)

    return_array_text = []

    if type.eql? :description
       for i in 0..aux_text.count - 1
           return_array_text <<  aux_text[i] 
        end
    end

    return return_array_text
  end

  def type_query(selector, type)  
      return set_query_for_all(selector,type)      
  end

  def get_values_array(selector,type)
    return_array_text_prev = []
    return_array = []
    return_array_text = type_query(selector, type)

    var = return_array_text == return_array_text_prev

    while var == false
      return_array << return_array_text
      return_array_text_prev = return_array_text
      scroll_down_selector
      return_array_text =  type_query(selector, type)
      var = return_array_text == return_array_text_prev
    end

    for index in 1..return_array.count - 1
      return_array[index].delete_at(0)
    end

     count = return_array.count - 1

    if (count > 0)
      count_prev = return_array.count - 2
      return_array[count] = return_array[count] - return_array[count_prev]
    end

    return return_array.flatten
  end

  def get_values_table(selector,type)
    return_array = get_values_array(selector,type)
  end

  def get_cells_date(selector, section=0)
     return get_values_table(selector, :date)
  end

  def select_cell(selector, position, time=50)
    wait("#{selector[PLATFORM]} index:#{position}", time.to_i)
    touch("#{selector[PLATFORM]} index:#{position}")
  end

end