class VariablecostValue < ApplicationRecord
  RERISTRABLE_ATTRIBUTES = %i(variablecost_id year_month)
  attr_accessor :variablecost_id
  attr_accessor :year_month
  attr_accessor :value
  attr_accessor :description
end
