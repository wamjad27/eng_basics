# generates, stores and calculates retained fibonacci sequence numbers
class Fibs
  attr_reader :generated_fibs

  def initialize
    @generated_fibs = []
  end

  def generate(nums)
    raise ArgumentError, 'Argument must be an integer and greater than zero' unless nums.is_a?(Integer) && nums > 0

    generate_fibs nums if nums > generated_fibs.length
    nums
  end

  def known_fib?(num)
    raise ArgumentError, 'Argument must be an integer and greater than zero' unless num.is_a?(Integer) && num > 0

    generated_fibs.include? num
  end

  def all_fibs?(seq_array)
    raise ArgumentError, 'Argument must be an array' unless seq_array.is_a?(Array)

    return false if seq_array.empty?

    seq_array.each do |s|
      return false unless fib_num?(s)
    end
    true
  end

  def known_fibs_sum_of_squares
    @generated_fibs.inject(0) { |sum, x| sum + x * x }
  end

  private

  def generate_fibs(nums)
    @generated_fibs.push(0) if @generated_fibs.empty?
    @generated_fibs.push(1) if nums >= 2 && @generated_fibs.length == 1
    iterations = nums - @generated_fibs.length
    iterations.times do
      @generated_fibs.push(@generated_fibs[-2] + @generated_fibs.push[-1])
    end
  end

  def fib_num?(num)
    perfect_square?(5 * num * num + 4) || perfect_square?(5 * num * num - 4)
  end

  def perfect_square?(num)
    (Math.sqrt(num) % 1).zero?
  end
end
