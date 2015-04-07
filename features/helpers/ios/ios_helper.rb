require 'calabash-cucumber/operations'
include ::Calabash::Cucumber::Operations

module IosHelper
  
  PLATFORM = :ios

  def who_i_am
    PLATFORM
  end

  # Check elements exist

  def check_element(selector, force_view=true)
    p "Checking #{selector[PLATFORM]}"
    found = element_exists("#{selector[PLATFORM]}")
    p "Found!!!" if found
    p "Not found!" unless found
    return found
  end

  def check_with_timeout(selector, timeout=10)
    while timeout > 0
      return true if element_exists("#{selector[PLATFORM]}")
      trace_sleep(1)
      timeout -= 1
    end
    false
  end

  def predicate_contains(selector,value)
    element_exists("#{selector[PLATFORM]} {text CONTAINS '#{value}'}")
  end

  def get_text(selector,value)
    wait(selector)
    element_exists("#{selector[PLATFORM]} marked:'#{value}'")
  end

  def get_with_text(selector,value)
    wait(selector)
    query("#{selector} text:'#{value}'",:text)[0]
  end

  def get_first_text(selector)
    p 'get value text'
    wait(selector)
    p query("#{selector[PLATFORM]}",:text)[0]
  end

  # Wait for elements

  def wait_screen_title(selector, title, time=50)
    wait_for_elements_exist(["* marked:'#{title}'" ], :timeout=>time.to_i)
  end

  def wait_for_message(selector, msg, time=30)
    wait_for_elements_exist(["#{selector[PLATFORM]} marked:'#{msg}'"], :timeout=>time.to_i)
  end

  def wait_for_message_predicate(selector, msg, time=10)
    wait_for_elements_exist(["#{selector[PLATFORM]} {text CONTAINS '#{msg}'}" ], :timeout=>time.to_i)
  end

  def wait_for_any_message(selector, messages, timeout=30)
    while timeout > 0
      messages.each do |msg|
        return true if element_exists("#{selector[PLATFORM]} marked:'#{msg}'")
      end
      trace_sleep(1)
      timeout -= 1
    end
    fail("Timeout reached in wait_for_any_message #{messages}")
  end

  def wait_while_exists(selector, time=20)
    wait_for_elements_do_not_exist(["#{selector[PLATFORM]}"], timeout: time.to_i)
  end

  def wait_label_marked(selector,value,time=50)
  	 wait_for_elements_exist("#{selector[PLATFORM]} label marked:'#{value}'", :timeout=>time.to_i)
  end

  # Tap on elements

  def tap(selector, time=30, force_view=false)
    wait(selector, time, force_view)
    trace_sleep(1)
	touch("#{selector[PLATFORM]}")
  end

  def tap_in_cell_row(selector, position, time=50)
    wait(selector)
    # If no sleeping following touch fails
    trace_sleep(1)
    touch("#{selector[PLATFORM]} index:#{position.to_i}")
  end

  def tap_in_ui_component_marked(selector,value, time=50)
    wait_label_marked(selector,value)
    trace_sleep(1)
	touch("#{selector[PLATFORM]} label marked:'#{value}'")
  end

  def tap_component_index(selector, index)
    trace_sleep(1)
    touch("#{selector[PLATFORM]} index:#{index}")
  end

  # Fill inputs

  def fill(selector, value, force_type=false)
    if force_type
      query("#{selector[PLATFORM]}", :setText=>'')
      tap(selector)
      p "Tapped. Ready to fill text..."
      keyboard_enter_text(value)
      element_exists("UIButton label marked:'OK'") ? touch("UIButton label marked:'OK'") : tap_keyboard_action_key
    else
      wait(selector)
      trace_sleep(1)
      query("#{selector[PLATFORM]}", :setText=>value)
      touch("UIButton label marked:'OK'") if element_exists("UIButton label marked:'OK'")
    end
  end

  # Scroll

  def scroll_to_element(scroll_selector, selector)
      wait_poll(:until_exists => "#{selector[PLATFORM]}", :timeout => 2) do
        scroll(scroll_selector[PLATFORM], :down)
      end
  end

  def scroll_to_element_with_text(scroll_selector, selector, text)
      wait_poll(:until_exists => "#{selector[PLATFORM]} label marked:'#{text}'", :timeout => 2) do
        scroll(scroll_selector[PLATFORM], :down)
      end
  end

  def scroll_to_cell_number(selector, section)
      scroll_to_cell(:row => 0, :section => section)
      trace_sleep(1)
  end

  def scroll_down_selector(selector)
     scroll("#{selector[PLATFORM]}",:down)
  end

  def scroll_up_selector(selector)
    scroll("#{selector[PLATFORM]}",:up)
  end

  def scroll_to_row_number(selector, index)
    scroll_to_row("#{selector[PLATFORM]}",index)
  end
  # Swipe

  def swipe_right_screen
    swipe(:right, query:"*", :"swipe-delta" => {:horizontal => {:dx=>180}})
    #swipe(:right)
    trace_sleep(2)
  end

  def swipe_left_screen
    swipe(:left)
    trace_sleep(2)
  end

  # Switchs

  def switch_is_checked_on(selector)
    query("#{selector[PLATFORM]}",:isOn)[0].to_i == 1
  end

  def switch_status(selector, status)
    wait(selector)
    if status #on true
      tap(selector) unless switch_is_checked_on(selector)
    else
      tap(selector) if switch_is_checked_on(selector)
    end
  end

  # Date pickers

  def picker_date(selector, day, month, year)
    tap(selector)
    picker_set_date_time(DateTime.new(year, month, day), notify_targets: true)
    touch("UIButton label marked:'OK'") if element_exists("UIButton label marked:'OK'")
  end

  def picker_table(selector,index)
    query("#{selector} index:'#{index}'", [{selectRow:index}, {animated:1}, {notify:1}])
    touch("UIButton label marked:'OK'") if element_exists("UIButton label marked:'OK'")
  end

  # Tables

  def count_cells(selector)
    query("#{selector[PLATFORM]}").count
    each_cell(:post_scroll=>0.1) do |row|
      @count = row
    end
  end

  def count_cells_table(selector)
    value = query("#{selector[PLATFORM]}").count
    puts "Count: #{value}"
    return value
  end

  def get_value(selector, index=0)
    query("#{selector[PLATFORM]}", :text)[index]
  end

  def select_cell(selector, position, time=50)
    wait_for_elements_exist("#{selector[PLATFORM]} index:#{position}", :timeout=>time.to_i)
    touch("#{selector[PLATFORM]} index:#{position}")
  end

  def get_cells_text(selector, section=-2)

    @text_array = []
    begin
      each_cell(:animate => false, :post_scroll => 0.1) do |row, sec|
        full_row = query("#{selector[PLATFORM]} indexPath:#{row},#{sec} label", :text)
        section_cell = 3
        if full_row[section_cell] != nil
          @text_array << full_row[section_cell].to_s
        end
      end
    rescue
      puts "Error: #{$!}"
    end
    return @text_array
  end

  def get_cells_text_for_swipe(selector)
    get_cells_text(selector, -2)
  end

  def get_cells_text_for_swipe_dict(selector)
    get_cells_text(selector)
  end

end