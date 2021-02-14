require_relative 'modules/company.rb'

class Carriage
  include Company

  attr_accessor :capacity, :code

  def initialize(capacity = 10, code = rand(10000..99999))
    @capacity = capacity
    @code = code
    valid?
  end

  private

  def valid?
    raise 'Недопустимое значение вместимости вагона' unless capacity < 1
    raise 'Номер вагона должен быть целым числом' unless code.integer?
    true
  end
end