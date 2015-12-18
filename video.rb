class Shop
  attr_accessor :library, :r_price, :c_price, :n_price, :o_price

  def initialize
    #@library = godfather: "R", junglebook: "C", themartian: "N", metropolis: "O"}
    @library = Array.new
    load_library
    print_library
    interface
  end

  def interface
    while true
      puts
      puts "Commands: invoice, list"
      puts "'CTRL C' to exit"
      input = gets.chomp

      case input
      when "invoice", "i"
        create_invoice
      when "list", "l"
        print_library
      else
        puts "Invalid Command!"
      end
    end
  end

  def create_invoice
    puts ""
    puts "Creating Invoice...(enter '123' when you are finished!)"
    puts "Enter Customer Name: "
    name = gets.chomp
    @customer_2 = Customer.new(name)
    puts "customer 2 = " + @customer_2.name

    loop do
      print "Enter Movie Title: "
      title = gets.chomp
      break if title == "123"
      puts ""
      print "Number of Days: "
      duration = gets.chomp
    end

  end

  def load_library
    @library.push Movie.new("the godfather", "R")
    @library.push Movie.new("jungle book", "C")
    @library.push Movie.new("the martian", "N")
    @library.push Movie.new("metropolis", "O")
  end

  def print_library
    @library.each do |movie|
      puts""
      puts "Title: " + movie.title
      puts "Type: " + movie.type
      puts "Price per day: " + movie.price.to_s
    end
  end

end



class Movie
  attr_accessor :title, :type, :price
  def initialize(title, type)
    @r_price = 2
    @c_price = 1.5
    @n_price = 3
    @o_price = 1.5

    @title = title
    @type = type
    @price = get_price(@type)
  end

  def get_price(type)
    case type
    when "R"
      @r_price
    when "C"
      @c_price
    when "N"
      @n_price
    when "O"
      @o_price
    end
  end
end

class Customer
  attr_accessor :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end
end

@shop = Shop.new
@customer = Customer.new("bob")
puts @customer.name
