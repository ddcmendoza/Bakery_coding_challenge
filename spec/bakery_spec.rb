# frozen_string_literal: true

require_relative '../bakery'

RSpec.describe Bakery do
  context 'Check given test points:' do
    it '10 VS5 should result to 2 x 5' do
      expect(described_class.new(10).vs5_by_5).to equal(2)
      expect(described_class.new(10).vs5_by_3).to equal(0)
      expect(described_class.new(10).vs5_by_1).to equal(0)
    end

    it '14 MB11 should result to 1 x 8, 3 x 2' do
      expect(described_class.new(0, 14).mb11_by_8).to equal(1)
      expect(described_class.new(0, 14).mb11_by_5).to equal(0)
      expect(described_class.new(0, 14).mb11_by_2).to equal(3)
      expect(described_class.new(0, 14).mb11_by_1).to equal(0)
    end

    it '13 CF should result to 2 x 5, 1 x 3' do
      expect(described_class.new(0, 0, 13).cf_by_9).to equal(0)
      expect(described_class.new(0, 0, 13).cf_by_5).to equal(2)
      expect(described_class.new(0, 0, 13).cf_by_3).to equal(1)
      expect(described_class.new(0, 0, 13).cf_by_1).to equal(0)
    end
  end

  context 'Accept value from 0 - 100' do
    (0..100).each do |x|
      t = described_class.new(x, x, x)
      it "Total should be equal to #{x}" do
        expect(5 * t.vs5_by_5 + 3 * t.vs5_by_3 + t.vs5_by_1).to equal(x)
        expect(8 * t.mb11_by_8 + 5 * t.mb11_by_5 + 2 * t.mb11_by_2 + t.mb11_by_1).to equal(x)
        expect(9 * t.cf_by_9 + 5 * t.cf_by_5 + 3 * t.cf_by_3 + t.cf_by_1).to equal(x)
      end
      next unless x > 2

      it "Total number of package less than #{x}" do
        expect(t.cf_by_9 + t.cf_by_5 + t.cf_by_3 + t.cf_by_1).to be < x
        expect(t.vs5_by_5 + t.vs5_by_3 + t.vs5_by_1).to be < x
        expect(t.mb11_by_8 + t.mb11_by_5 + t.mb11_by_2 + t.mb11_by_1).to be < x
      end
    end
  end
end
