require_relative '../fibs'

describe Fibs do
  subject { Fibs.new }

  describe '#generate' do
    let(:expected_result) {
      [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ]
    }

    it 'returns the number of requested fibonacci numbers' do
      expect( subject.generate(10) ).to eq(expected_result)
    end

    it 'stores the values' do
      subject.generate(10)
      expect( subject.generated_fibs ).to eq(expected_result)
    end

    context 'when it already knows the requested number of sequence numbers' do
      before do
        subject.generate(5)
        allow_any_instance_of(Fibs).to receive(:generate_fibs) { raise Exception }
      end

      it 'does not call generate_fibs' do
        # write an expectation for calling generate
      end
    end
  end

  describe '#is_known_fib?' do
    context 'when passed a fibonacci number that it has not stored' do
      it 'returns false' do
      end
    end

    context 'when passed a number that has been stored' do
      it 'returns true' do
      end
    end
  end

  describe '#all_fibs?' do
    context 'when passed an array of numbers that are all members of the the fibonacci sequence' do
      it 'returns true' do
      end
    end

    context 'when passed an array of numbers that where at least one is not a member of the sequence' do
      it 'returns false' do
      end
    end
  end

  describe '#known_fibs_sum_of_squares' do
    let(:expected_result) {
      # the known sum of the squares
    }

    context 'when there are stored numbers' do
      before do
        # seed generated_fibs
      end

      it 'returns the sum of the squared values for all known fibs' do
        expect( subject.known_fibs_sum_of_squares ).to eq( expected_result )
      end
    end

    context 'when there are no stored numbers' do
      it 'returns 0' do
        expect( subject.known_fibs_sum_of_squares ).to eq( 0 )
      end
    end
  end
end
