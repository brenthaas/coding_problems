
class Array
  def pivot_index
    current_sum = 0
    tail_sums = get_tail_sums
    self.each_with_index do |el, i|
      current_sum += el
      return i if current_sum == tail_sums[i]
    end
    return -1
  end

  private

    def get_tail_sums
      current_sum = 0
      tail_sums = []
      self.reverse_each do |el|
        current_sum += el
        tail_sums.unshift current_sum     #put the sum on the front of the list of sums (reverse of push)
      end
      tail_sums
    end
end
