class Fib < ApplicationRecord
  attr_accessor :generated_fibs

  def set_values max = 0
    generate(max.to_i)
    self.max_number = max
    self.sequence = @generated_fibs.join(',')
    self.squares = known_fibs_sum_of_squares
  end

  def generate x
    raise ArgumentError if x < 1
    return @generated_fibs[0,x] if x <= Array(@generated_fibs).count
    fibs_array = []
    (0...x).each do |elem|
      fibs_array << generate_fibs(elem)
    end
    @generated_fibs = fibs_array
  end

  def is_known_fib? num
    @generated_fibs.include?(num)
  end

  def all_fibs? seq_array
    (seq_array & @generated_fibs).size == seq_array.size
  end

  def known_fibs_sum_of_squares
    return 0 if @generated_fibs.nil?
    @generated_fibs.inject(0) {|sum, x| sum + x**2}
  end

  private

  # added cache for speed
  def generate_fibs(x)
    @cache ||= {}
    return x if (0..1).cover? x

    a = @cache.fetch(x - 1) do
      @cache[x - 1] = generate_fibs(x - 1)
    end
    b = @cache.fetch(x - 2) do
      @cache[x - 2] = generate_fibs(x - 2)
    end
    a + b
  end

end
