class Money
  attr_accessor :amount, :currency

  #Set defaults
  @@base_currency = 'EUR'
  @@conversion_rates = {
    'EUR' => 1,
    'USD' => 1.11,
    'Bitcoin' => 0.0047
  }

  #Constructor
  def initialize(amount, currency)
    @amount = amount.to_f
    @currency = currency
  end

  def self.conversion_rates(base_currency, conversion_rates)
		@@base_currency = base_currency
		@@conversion_rates = conversion_rates
	end

  #Convert method
  def convert_to(to_currency)
    if @@conversion_rates[to_currency].nil?
      puts 'Rate not found'
    else
      from_currency = self.currency
      rate = Money.getRate(from_currency, to_currency)
    
      converted_amount = self.amount * rate

      Money.new(converted_amount, to_currency)
    end
  end

  #Arithmetics
  def other_amount(other)
    rate = Money.getRate(other.currency, self.currency)
    other.amount * rate
  end

  def +(other)
    Money.new(self.amount + other_amount(other), self.currency)
  end

  def -(other)
    Money.new(self.amount - other_amount(other), self.currency)
  end

  def *(number)
    Money.new(self.amount * number.to_f, self.currency)
  end

  def /(number)
    Money.new(self.amount / number.to_f, self.currency)
  end

  #Comparisons
  def ==(other)
    temp = other.convert_to(self.currency)
    self.amount.round(2) == temp.amount.round(2)
  end

  def >(other)
    temp = other.convert_to(self.currency)
    self.amount.round(2) > temp.amount.round(2)
  end

  def <(other)
    temp = other.convert_to(self.currency)
    self.amount.round(2) < temp.amount.round(2)
  end

  def inspect
    sprintf('%.2f %s', amount, currency)
  end

  def to_s
    sprintf('%.2f %s', amount, currency)
  end

  def self.getRate(from_currency, to_currency)

    if !@@conversion_rates[to_currency].nil? && from_currency == @@base_currency
      return @@conversion_rates[to_currency]
    end

    if !@@conversion_rates[from_currency].nil? && to_currency == @@base_currency
      return 1.0 / @@conversion_rates[from_currency]
    end
  end

end