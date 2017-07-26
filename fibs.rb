# generates, stores and calculates retained fibonacci sequence numbers

class Fibs
  attr_accessor :generated_fibs
  attr_reader :space

  def generate x
    @space = x
    @generated_fibs ||= [0,1]
    if generated_fibs.size >= x
      generated_fibs.first(x)
    else
      generate_fibs x
    end
  end

  def is_known_fib? num
    num > 1 && generated_fibs.include?(num)
  end

  def all_fibs? seq_array
    seq_array.size == space
  end

  def known_fibs_sum_of_squares
    @generated_fibs ||= []
    generated_fibs.map {|n| n**2}.inject(0) {|sum, x| sum + x }
  end

  private

  def generate_fibs x
    if all_fibs? generated_fibs
      generated_fibs
    else
      num = generated_fibs[-1] + generated_fibs[-2]
      generated_fibs << num unless is_known_fib? num
      generate_fibs x-1
    end
  end
end
