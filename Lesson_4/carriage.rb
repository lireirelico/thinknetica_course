require_relative 'modules/company.rb'

class Carriage
  include Company

  attr_accessor :capacity, :code

  def initialize(capacity = 10, code = rand(10000..99999))
    @capacity = capacity
    @code = code
  end
end