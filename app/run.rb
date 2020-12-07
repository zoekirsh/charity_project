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
  p1 = ""
  p2 = ""

  until user_input == "quit" || user_input == "exit" || user_input == "!!!"
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
      p1 = how_many
      pp x_most_common_categories(p1)
      user_input = gets_input
    when "3" then
      pp activitiesAndCount
      user_input = gets_input
    when "4" then
      p1 = how_many
      pp x_most_common_activities(p1)
      user_input = gets_input
    when "5" then
      pp statesAndCount
      user_input = gets_input
    when "6" then
      p1 = how_many
      pp x_states_with_most_charities(p1)
      user_input = gets_input
    when "7" then 
      pp charity_names_in(state)
      user_input = gets_input
    when "8" then
      pp charity_categories_in(state)
      user_input = gets_input
    when "9" then
      pp charity_activities_in(state)
      user_input = gets_input
    when "10" then
      puts nice(total_income_per_state)
      user_input = gets_input
    when "11" then
      puts nice(avg_incomes)
      user_input = gets_input
    when "12" then
      puts rank_by_avg_income(state)
      user_input = gets_input
    when "13" then
      p1 = which_activity
      puts nice(total_income_for_activity_by_state(p1))
      user_input = gets_input
    when "14" then
      p1 = which_activity
      puts state_with_highest_income_for(p1)
      user_input = gets_input
    when "15" then
      p1 = which_activity
      puts rank_by_income_for_activity_by(state, p1)
      user_input = gets_input
    when "16" then
      puts nice(sum_of_activity_incomes_array)
      user_input = gets_input
    when "17" then
      p1 = which_activity
      puts percentage_of_income_for(p1)
      user_input = gets_input
    when "18" then
      puts nice(sum_of_legal_fees_by_category)
      user_input = gets_input
    when "19" then
      puts nice(avg_legal_fees_by_category)
      user_input = gets_input
    when "20" then
      puts nice(sum_of_mgmnt_fees_by_category)
      user_input = gets_input
    when "21" then
      puts nice(avg_mgmnt_fees_by_category)
      user_input = gets_input
    else puts "Please enter a valid command:"
      user_input = gets_input
    end
  end
  puts "We hope you enjoyed learning some more about Non-Profits. Goodbye!"
end

def menu
  puts "-------------------------------------"
  # puts "Type 'national' for commands comparing states."
  # puts "Type 'state' for commands inquiring within a specific state."
  # puts "Type 'financial' for commands relating to finance."
  puts "Type '1' for a list of all Non-Profit categories and their organization count"
  puts "Type '2' for the most common Non-Profit categories"
  puts "Type '3' for a list of all Non-Profit activities and their count"
  puts "Type '4' for the most common Non-Profit activities"
  puts "Type '5' for a count of Non-Profits in each state"
  puts "Type '6' for the states with the most Non-Profits"
  puts "Type '7' for a list of all Non-Profits in your chosen state"
  puts "Type '8' for a list of all Non-Profit categories in your chosen state and their count"
  puts "Type '9' for a list of all Non-Profit activities in your chosen state and their count"
  puts "Type '10' for the total income of all Non-Profits in each state"
  puts "Type '11' for the average income of all Non-Profits in each state"
  puts "Type '12' for your chosen state's rank by average income"
  puts "Type '13' for the total income for an activity across each state"
  puts "Type '14' for the state with the highest income for an activity"
  puts "Type '15' for the rank by income for an activity in your chosen state"
  puts "Type '16' for the sum of incomes associated with each activity"
  puts "Type '17' for the percentage of Non-Profit income associated with an activity"
  puts "Type '18' for the sum of legal fees by category"
  puts "Type '19' for the average legal fee by category"
  puts "Type '20' for the sum of management fees by category"
  puts "Type '21' for the average management fee by category"
  puts "Interested in a different state? Type 'change state'."
  puts "Type 'quit' any time to exit program."
end

def how_many
  puts "How many would you like to see?"
  num = STDIN.gets.chomp.to_i
  until num > 0
    puts "Invalid input. Please enter a number"
    num = STDIN.gets.chomp.to_i
  end
  num
end

def which_activity
  puts "Which activity are you interested in?"
  activity = STDIN.gets.chomp
  until activitiesAndCount.flatten.include?(activity) || activity == 'exit'
    puts "Invalid input. Please enter a valid activity, or type 'exit' to return to menu"
    activity = STDIN.gets.chomp
  end
  activity
end

def gets_input
  puts "-------------------------------------"
  p "Please enter a command:"
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
