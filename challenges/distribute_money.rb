def distribute(amount, recipients)
  amount_paid = {}
  while amount > 0 and recipients.select { |k, v| v > 0 }.count > 0
    filtered_recipients = recipients.select { |k, v| v > 0 }
    recipient_values = filtered_recipients.values
    minimum_amount_owed = recipient_values.min
    amount_to_distribute = minimum_amount_owed * recipient_values.count
    if amount_to_distribute <= amount
      amount -= amount_to_distribute
      filtered_recipients.keys.each do |recipient|
        amount_paid[recipient] = 0 unless amount_paid[recipient]
        amount_paid[recipient] += minimum_amount_owed
        recipients[recipient] -= minimum_amount_owed
      end
    else
      minimum_amount_owed = (amount / recipient_values.count).floor
      amount_to_distribute = minimum_amount_owed * recipient_values.count
      amount -= amount_to_distribute
      filtered_recipients.keys.each do |recipient|
        amount_paid[recipient] = 0 unless amount_paid[recipient]
        amount_paid[recipient] += minimum_amount_owed
        recipients[recipient] -= minimum_amount_owed
      end
      break
    end
  end
  amount_paid
end

puts distribute(40, { a: 10, b: 10, c: 10, d: 10 }) == { a: 10, b: 10, c: 10, d: 10 }
puts distribute(50, { a: 15, b: 10, c: 10, d: 10 }) == { a: 15, b: 10, c: 10, d: 10 }
puts distribute(39, { a: 10, b: 10, c: 10, d: 10 }) == { a: 9, b: 9, c: 9, d: 9 }
