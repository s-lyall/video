=begin
require './movie'
require './customer'

movie1 = Movie.new('bla','C')
customer1 = Customer.new
customer.rents(movie1, 1.day)

=end

#attr_accessor :o1

class C1

  def m1
    puts "m1 called"
  end

end

class C2

  def initialize (obj)
    @my_o1 = obj
  end

  def m2
    puts "m2 called"
    @my_o1.m1
  end

end



@o1 = C1.new
@o2 = C2.new(@o1)

@o1.m1
@o2.m2
