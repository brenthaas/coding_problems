
#Balance point is 0-index vs index+1-end
# so  [1, 2, 3, 3, 2, 1] = 2  (sum of [1, 2, 3] == sum of [3, 2, 1])

class BalanceArray
	def self.balance(ary)
		return nil if ary.length < 2

		running_sum = 0
		left_sum = ary.map do |num|
			running_sum += num
		end

		running_sum = 0
		previous_num = 0  # stores the last index
		right_sum = ary.reverse.map { |num|
			running_sum += previous_num
			previous_num = num  #store for next time
			running_sum
		}.reverse

		ary.each_index do |index|
			return index if right_sum[index] == left_sum[index]
		end

		return nil	# no balance point found
	end
end
