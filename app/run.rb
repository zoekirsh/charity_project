require_relative "./charity_controller.rb"
require_relative 'models/charity.rb'
require_relative 'models/charity_activity.rb'
require_relative 'models/activity.rb'

def welcome
  puts "Welcome to Ben and Zoe's Phase 1 Project!"
  puts "We have created a database of Non-Profit Organizations."
end

def run
  welcome
  state = get_state
  puts "State successfully set to #{state}."
  puts "-------------------------------------"
  puts "Type 'menu' for a list of possible commands:"
  user_input = gets_input

  until user_input == "quit" 
    case user_input
    when "menu" then 
      menu
      user_input = gets_input
    when "change state" then
      state = get_state
      puts "State successfully changed to #{state}!"
      user_input = gets_input
    when "1" then 
      pp categoriesAndCount
      user_input = gets_input
    when "2" then 
      puts charities_in(state)
      user_input = gets_input
    else puts "Please enter a valid command:"
      user_input = gets_input
    end
  end
  puts "We hope you enjoyed learning some more about Non-Profits. Goodbye!"
end

def gets_input
  puts "-------------------------------------"
  puts "Please enter a command:"
  STDIN.gets.chomp
end

def get_state
  puts "Please enter a state:"
  state = STDIN.gets.chomp
  until statesAndCount.map {|s| s[0]}.include?(state)
    puts "State not represented or incorrect spelling. Please try again!"
    state = STDIN.gets.chomp
  end
  state
end

def menu
  puts "-------------------------------------"
  puts "Interested in a different state? Type 'change state'."
  # puts "Type 'national' for commands comparing states."
  # puts "Type 'state' for commands inquiring within a specific state."
  # puts "Type 'financial' for commands relating to finance."
  puts "Type '1' for a list of all types of Non-Profits with their organization count"
  puts "Type '2' for a list of Non-Profits in your chosen state"
end

# run