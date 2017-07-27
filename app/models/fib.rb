class Fib < ApplicationRecord
  validates_numericality_of :space, greater_than: 0, only_integer: true

  def as_json(options = {})
    super((options).merge({
      methods: [:generated_fibs, :known_fibs_sum_of_squares]
    }))
  end

  def generate
    return generated_fibs.first(space) if generated_fibs.size >= space
    @seq_array = generated_fibs
    self.fibs = generate_fibs(space).join(',')
    self.save
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

  def generated_fibs
    self.fibs.split(',').map(&:to_i).first(space)
  end

  def known_fibs_sum_of_squares
    generated_fibs.map {|n| n**2}.inject(0) {|sum, x| sum + x }
  end

  private

  def generate_fibs x
    return @seq_array if @seq_array.size == space
    @seq_array << next_number
    generate_fibs x-1
  end

  def next_number
    @seq_array = [0, 1] if @seq_array.empty?
    @seq_array.last(2).inject(&:+)
  end
end
