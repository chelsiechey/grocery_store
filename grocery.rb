# Display a menu in the console for the user to interact with.
# Create a default array of hashes that represent items at a grocery store.
# Create a menu option to add items to a user's grocery cart.
# Create a menu option to display all the items in the cart.
# Create a menu option to remove an item from the users cart.
# Create a menu option to show the total cost of all the items in the user's cart.
# Add new items to the grocery store.
# Zip it up and turn it in!

require 'titleize'
require 'colorize'

@user_wallet = []
@prices = []
@user_cart = []
@grocery = [{
  item: 'Milk',
  price: 2.00,
  quantity: 8
  },
  {
    item: 'Butter',
    price: 1.50,
    quantity: 1000
  },
  {
    item: 'Bread',
    price: 3.00,
    quantity: 2
  }]

def separator
  puts "************"
end

def intro
  puts 'Welcome to Chelsie\'s Grocery!'
  puts 'What\'s your name?'
  @user_name = gets.strip.titleize
  puts "Hello #{@user_name}! Thank you for choosing Chelsie's Grocery."
  separator
  menu
end

def menu
  puts "What would you like to do?"
  puts "Select the Corresponding Number to Choose an Option"
  puts "1) Shop for Groceries"
  puts "2) View Cart"
  puts "3) Remove from Cart"
  puts "4) See Total Price"
  puts "5) See Available Funds"
  puts "6) Add Money to Account"
  puts "7) Checkout"
  puts "8) Add New Item to Store"
  puts "9) Exit"
  separator
  menu_options
end

def menu_options
  user_input = gets.chomp.to_i
  if user_input == 1
    groceries
  elsif user_input == 2
    user_cart
  elsif user_input == 3
    remove_cart
  elsif user_input == 4
    cost
  elsif user_input == 5
    see_wallet
  elsif user_input == 6
    add_money
  elsif user_input == 7
    checkout
  elsif user_input == 8
    add_grocery
  elsif user_input == 9
    exit
  else
    puts "Invalid response, try again!"
    menu_options
  end
end

def groceries
  puts "--- Shop for Groceries ---"
  @grocery.each_with_index do |i, index|
    printf("%d) %s: $%.2f, %d remaining.\n", index + 1, i[:item], i[:price], i[:quantity])
  end
  puts "#{@grocery.length + 1}) Go Back"
  puts "What would you like to add to your cart?"
  grocery_options
  @user_cart << @grocery[@selection - 1][:item]
  @prices << @grocery[@selection - 1][:price]
  @grocery[@selection - 1][:quantity] = @grocery[@selection - 1][:quantity] - 1
  separator
  menu
end

def check_if_back
  @selection = gets.chomp
  if @selection.to_i == @grocery.length + 1
    separator
    menu
  else
  end
end

def grocery_options
  check_if_back
  if @selection.to_i.to_s == @selection
    @selection = @selection.to_i
    grocery_option_length_check
  else
    puts "Invalid response, try again!"
    grocery_options
  end
end

def grocery_option_length_check
  if @selection <= @grocery.length && @selection > 0
    grocery_quantity_check
  else
    puts "Invalid response, try again!"
    grocery_options
  end
end

def grocery_quantity_check
  if @grocery[@selection - 1][:quantity] > 0
    printf("Adding %s to your cart for $%.2f\n", @grocery[@selection - 1][:item], @grocery[@selection - 1][:price])
  else
    puts "This item is out of stock! Please select something else."
    grocery_options
  end
end

def see_wallet
  puts ' --- Available Funds ---'
  printf("Hello, %s! You have $%.2f left in your account.\n", @user_name, @user_wallet.sum)
  separator
  menu
end

def add_money
  puts "--- Add Money ---"
  printf("Hello, %s! You have $%.2f left in your account.\n", @user_name, @user_wallet.sum)
  puts "How much would you like to add?"
  puts "Type 'quit' to return to the menu at any time."
  is_quit
  separator
  menu
end

def is_quit
  @add = gets.strip.capitalize
  if @add == 'Quit'
    separator
    menu
  else
    add_money_options
  end
end

def add_money_options
  pattern = /^(\d+\.?){1}(\d*){0,1}$/
  if pattern.match(@add)
    @add = @add.to_f
    @user_wallet << @add
    printf("Alright, you have added $%.2f to your account.\n", @add)
    printf("Your new balance is $%.2f.\n", @user_wallet.sum)
  else
    puts "Invalid response, try again."
    is_quit
  end
end


def display_cart
  @user_cart.each_with_index do |i, index|
    puts "#{index + 1}) #{i}"
  end
end

def user_cart
  puts "--- View Cart ---"
  display_cart
  separator
  menu
end

def remove_cart
  puts "--- Remove from Cart ---"
  puts "Which item would you like to remove?"
  puts "Select the corresponding number to choose an option."
  display_cart
  puts "#{@user_cart.length + 1}) Go Back"
  remove_cart_options
  separator
  menu
end

def check_back_remove
  @selection = gets.chomp
  if @selection.to_i == @user_cart.length + 1
    menu
  else
  end
end


def remove_cart_options
  check_back_remove
  if @selection.to_i.to_s == @selection
    @selection = @selection.to_i
    cart_length_check
  else
    puts "Invalid response, try again!"
    check_if_back
    remove_cart_options
  end
end

def cart_length_check
  if @selection <= @user_cart.length && @selection > 0
    printf("Removing %s for $%.2f from you cart.\n", @user_cart[@selection - 1], @prices[@selection - 1])
    @user_cart.delete_at(@selection - 1)
    @prices.delete_at(@selection - 1)
    @grocery[@selection - 1][:quantity] = @grocery[@selection - 1][:quantity] + 1
  else
    puts "Invalid response, try again!"
    remove_cart_options
  end
end

def cost
  puts "--- Total Price ---"
  printf("Your total comes to $%.2f\n", @prices.sum)
  separator
  menu
end

def add_grocery
  puts "--- Add Item to Store ---"
  puts "What grocery item would you like to add?"
  puts "Type 'quit' to return to the menu at any time."
  @grocery_item = gets.strip.capitalize
  if @grocery_item == 'Quit'
    separator
    menu
  else
    add_stock
  end
end

def add_stock
  puts "How Many Are In Stock?"
  @number_stock = gets.strip
  if @number_stock.to_i.to_s == @number_stock
    @number_stock = @number_stock.to_i
    add_price
  elsif @number_stock == 'quit'
    separator
    menu
  else
    puts "Please Input a Whole Number"
    add_stock
  end
end

def add_price
  puts "How Much Will It Cost?"
  @grocery_price = gets.strip.capitalize
  pattern = /\$?\d{1,3}(,?\d{3})*(\.\d{1,2})?/
  if pattern.match(@grocery_price)
    @grocery_price = @grocery_price.to_f
    @new_item = { item: @grocery_item, price: @grocery_price, quantity: @number_stock}
    @grocery << @new_item
    separator
    menu
  elsif @grocery_price == 'Quit'
    separator
    menu
  else
    puts "Please enter a number."
    add_price
  end
end

def checkout
  puts "--- Checkout ---"
  puts "#{@user_name}'s Cart: "
  display_cart
  printf("Your total comes to $%.2f\n", @prices.sum)
  if @user_wallet.sum < @prices.sum
    puts "Add money to continue with checkout."
    separator
    menu
  else
    puts "Continue with checkout? (y/n)"
    continue_with_checkout
  end
end

def continue_with_checkout
  yes_or_no = gets.strip
    case yes_or_no
    when "y"
      @user_wallet << -(@prices.sum)
      @user_cart = []
      @prices = []
      printf("Your items are on their way! You're balance is now $%.2f\n", @user_wallet.sum)
      separator
      menu
    when "n"
      separator
      menu
    else
      puts "Invalid response, try again!"
      continue_with_checkout
    end
end

  
intro