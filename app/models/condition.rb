class Condition < ActiveRecord::Base
  FIELDS = %w(
    address1
    address2
    city
    province
    country
    postal_code
    company_name
    sku
  )

  VERBS = %w(
    regex
    include
    exclude
    equal
    start_with
    end_with
  )

  belongs_to :rate

  validates :field, inclusion: FIELDS
  validates :verb, inclusion: VERBS

  def valid_for?(string)
    return false if string.nil?

    case verb
    when 'regex'
      string.match(/#{value}/i)
    when 'include'
      string.include?(value)
    when 'exclude'
      string.exclude?(value)
    when 'equal'
      string == value
    when 'start_with'
      string.match(/\A#{value}/i)
    when 'end_with'
      string.match(/#{value}\z/i)
    end
  end
end
