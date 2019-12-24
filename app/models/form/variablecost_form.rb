class Form::VariablecostForm < Form::Base
  attr_accessor :variablecost_values

  def initialize(attributes = {})
  super attributes
  
    variablecosts = Variablecost.order(created_at: :asc)
    self.variablecost_values = attributes.map { |variablecost| VariablecostValue.new(variablecost_id: variablecost.id)} unless variablecost_values.present?
  end
  
  def variablecost_value_attributes=(attributes)
  self.variablecost_values = attributes.map do |_, variablecost_value_attributes|
    Form::VariablecostValue.new(variablecost_value_attributes).tap { |v| puts v}
  end
end

  def valid?
    valid_variablecost_values = self.valid_variablecost_values.map(&:valid?).all?
    super && valid_variablecost_values
  end
  
  def save
    return false unless valid?
    VariablecostValue.transaction 
  
end