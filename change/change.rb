class Change
  def get_change(total)
    @coins = {}
    after_quarters = get_coin_count(:quarters, 25, total)
    after_dimes = get_coin_count(:dimes, 10, after_quarters)
    after_nickles = get_coin_count(:nickles, 5, after_dimes)
    get_coin_count(:pennies, 1, after_nickles)
    @coins
  end

  private

  def get_coin_count(name, value, total)
    @coins[name] = total / value
    total - @coins[name] * value
  end
end


# {
#   quarters: 2,
#   nickles: 3
# }
