# generates, stores and calculates retained fibonacci sequence numbers

class Fibs
  attr_accessor :generated_fibs
  attr_reader :space

  def initialize
    @generated_fibs = []
  end

  def generate x
    return generated_fibs.first(x) if generated_fibs.size >= x
    @space = x
    generate_fibs x
  end

  def is_known_fib? num
    num > 1 && generated_fibs.include?(num)
  end

  def all_fibs? seq_array
    seq_array.all? do |n|
      num = 5 * n * n
      Math.sqrt((num + 4)) % 1 == 0 || Math.sqrt((num - 4)) % 1 == 0
    end
  end

  def known_fibs_sum_of_squares
    generated_fibs.map {|n| n**2}.inject(0) {|sum, x| sum + x }
  end

  private

  def generate_fibs x
    return generated_fibs if generated_fibs.size == space
    generated_fibs << next_number
    generate_fibs x-1
  end

  def next_number
    @generated_fibs = [0, 1] if generated_fibs.empty?
    generated_fibs.last(2).inject(&:+)
  end
end
