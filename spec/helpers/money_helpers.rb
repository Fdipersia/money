module MoneyHelpers
	def initialize_with_conversion_rates
		rates_hash = {
			'EUR' => 1,
			'USD' => 1.11,
			'Bitcoin' => 0.0047
		}
		Money.conversion_rates('EUR',rates_hash)
	end
end