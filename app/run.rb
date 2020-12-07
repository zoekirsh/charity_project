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
      puts "These are all the different categories of Non-Profits with the number of organizations belonging to each category:"
      puts "-------------------"
      pp categoriesAndCount
      user_input = gets_input
    when "2" then
      p1 = how_many
      puts "Here are the #{p1} most common Non-Profit categories:"
      pp x_most_common_categories(p1)
      user_input = gets_input
    when "3" then
      puts "These are all the different activities a Non-Profit can participate in, with a count of how many organizations engage in each activity:"
      puts "-------------------"
      pp activitiesAndCount
      user_input = gets_input
    when "4" then
      p1 = how_many
      puts "These are the #{p1} most common Non-Profit activities:"
      puts "-------------------"
      pp x_most_common_activities(p1)
      user_input = gets_input
    when "5" then
      puts "Here are all the Non-Profits in each state:"
      puts "-------------------"
      pp statesAndCount
      user_input = gets_input
    when "6" then
      p1 = how_many
      puts "These are the #{p1} states with the most Non-Profits:"
      puts "-------------------"
      pp x_states_with_most_charities(p1)
      user_input = gets_input
    when "7" then 
      puts "These are all the Non-Profits in #{state}:"
      puts "-------------------"
      pp charity_names_in(state)
      user_input = gets_input
    when "8" then
      puts "In #{state}, these are all the Non-Profit categories and how many organizations they have:"
      puts "-------------------"
      pp charity_categories_in(state)
      user_input = gets_input
    when "9" then
      puts "In #{state}, these are all the Non-Profit activities and how many organizations participate:"
      puts "-------------------"
      pp charity_activities_in(state)
      user_input = gets_input
    when "10" then
      puts "Here is the cumulative income of all the Non-Profits in each state:"
      puts "-------------------"
      puts nice(total_income_per_state)
      user_input = gets_input
    when "11" then
      puts "Here is the average income for a Non-Profit in each state:"
      puts "-------------------"
      puts nice(avg_incomes)
      user_input = gets_input
    when "12" then
      puts "#{state} is ranked the following for Non-Profit average income:"
      puts "-------------------"
      puts rank_by_avg_income(state)
      user_input = gets_input
    when "13" then
      p1 = which_activity
      puts "Here is the total income for the activity '#{p1}' by state:"
      puts "-------------------"
      puts nice(total_income_for_activity_by_state(p1))
      user_input = gets_input
    when "14" then
      p1 = which_activity
      puts "This is the state with the highest income for the activity '#{p1}':"
      puts "-------------------"
      puts state_with_highest_income_for(p1)
      user_input = gets_input
    when "15" then
      p1 = which_activity
      puts "-------------------"
      puts rank_by_income_for_activity_by(state, p1)
      user_input = gets_input
    when "16" then
      puts "Here are all the Non-Profit activities with the sum of income that is related to each:"
      puts "-------------------"
      puts nice(sum_of_activity_incomes_array)
      user_input = gets_input
    when "17" then
      p1 = which_activity
      puts "-------------------"
      puts "#{percentage_of_income_for(p1)} of national Non-Profit income is allocated to the activity '#{p1}'"
      user_input = gets_input
    when "18" then
      puts "The legal fees for all Non-Profits belonging to each category are the following:"
      puts "-------------------"
      puts nice(sum_of_legal_fees_by_category)
      user_input = gets_input
    when "19" then
      puts "Here are all the Non-Profit categories with their average legal fee:"
      puts "-------------------"
      puts nice(avg_legal_fees_by_category)
      user_input = gets_input
    when "20" then
      puts "The management fees for all Non-Profits belonging to each category are the following:"
      puts "-------------------"
      puts nice(sum_of_mgmnt_fees_by_category)
      user_input = gets_input
    when "21" then
      puts "Here are all the Non-Profit categories with their average management fee:"
      puts "-------------------"
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
