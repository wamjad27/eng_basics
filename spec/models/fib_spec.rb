require 'rails_helper'

RSpec.describe Fib, type: :model do
  subject { Fib.new }

  describe '#generate' do
    let(:expected_result) {
      [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ]
    }

    it 'returns the number of requested fibonacci numbers' do
      subject.space = 10
      subject.generate
      expect(subject.generated_fibs).to eq(expected_result)
      subject.space = 4
      subject.generate
      expect(subject.generated_fibs).to eq([0, 1, 1, 2])
      subject.space = 2
      subject.generate
      expect(subject.generated_fibs).to eq([0, 1])
      subject.space = 0
      subject.generate
      expect(subject.generated_fibs).to eq([])
    end

    it 'stores the values' do
      subject.space = 10
      subject.generate
      expect( subject.generated_fibs ).to eq(expected_result)
    end

    context 'when it already knows the requested number of sequence numbers' do
      before do
        subject.space = 5
        subject.generate
        allow_any_instance_of(Fib).to receive(:generate_fibs) { raise Exception }
      end

      it 'does not call generate_fibs' do
        subject.space = 5
        expect { subject.generate }.not_to raise_error
        subject.space = 3
        expect { subject.generate }.to_not raise_error(Exception)
        subject.space = 6
        expect { subject.generate }.to raise_error(Exception)
      end
    end
  end

  describe '#is_known_fib?' do
    before do
      subject.space = 6
      subject.generate
    end

    context 'when passed a fibonacci number that it has not stored' do
      it 'returns false' do
        expect( subject.is_known_fib?(12) ).to be_falsey
      end
    end

    context 'when passed a number that has been stored' do
      it 'returns true' do
        expect( subject.is_known_fib?(5) ).to be_truthy
      end
    end
  end

  describe '#all_fibs?' do
    before do
      subject.space = 10
      subject.generate
    end

    context 'when passed an array of numbers that are all members of the the fibonacci sequence' do
      it 'returns true' do
        expect( subject.all_fibs?([ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ]) ).to be_truthy
      end
    end

    context 'when passed an array of numbers that where at least one is not a member of the sequence' do
      it 'returns false' do
        expect( subject.all_fibs?([ 0, 1, 1, 2, 3, 5, 7 ]) ).to be_falsey
        expect( subject.all_fibs?([0, 1, 6]) ).to be_falsey
      end
    end
  end

  describe '#known_fibs_sum_of_squares' do
    let(:expected_result) { 1870 }

    context 'when there are stored numbers' do
      before do
        subject.space = 10
        subject.generate
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
