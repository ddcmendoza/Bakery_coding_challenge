# frozen_string_literal: true

require_relative '../bakery'

RSpec.describe Bakery do
  context 'Check given test points:' do
    it '10 VS5 should result to 2 x 5' do
      expect(described_class.new(10).vs5_by5).to equal(2)
      expect(described_class.new(10).vs5_by3).to equal(0)
      expect(described_class.new(10).vs5_by1).to equal(0)
    end

    it '14 MB11 should result to 1 x 8, 3 x 2' do
      expect(described_class.new(0, 14).mb11_by8).to equal(1)
      expect(described_class.new(0, 14).mb11_by5).to equal(0)
      expect(described_class.new(0, 14).mb11_by2).to equal(3)
      expect(described_class.new(0, 14).mb11_by1).to equal(0)
    end

    it '13 CF should result to 2 x 5, 1 x 3' do
      expect(described_class.new(0, 0, 13).cf_by9).to equal(0)
      expect(described_class.new(0, 0, 13).cf_by5).to equal(2)
      expect(described_class.new(0, 0, 13).cf_by3).to equal(1)
      expect(described_class.new(0, 0, 13).cf_by1).to equal(0)
    end
  end

  context 'Accept value from 0 - 100' do
    (0..100).each do |x|
      t = described_class.new(x, x, x)

      context "For #{x} amount should only output greater than 0" do
        it { expect((t.vs5_by_pack + t.mb11_by_pack + t.cf_by_pack).all? { |amount| amount >= 0 }).to be true }
      end
      context "Total should be equal to #{x}" do
        it { expect(5 * t.vs5_by5.abs + 3 * t.vs5_by3.abs + t.vs5_by1.abs).to equal(x) }
        it { expect(8 * t.mb11_by8.abs + 5 * t.mb11_by5.abs + 2 * t.mb11_by2.abs + t.mb11_by1.abs).to equal(x) }
        it { expect(9 * t.cf_by9.abs + 5 * t.cf_by5.abs + 3 * t.cf_by3.abs + t.cf_by1.abs).to equal(x) }
      end
      next unless x > 2

      context "Total number of packs less than #{x}" do
        it { expect(t.vs5_by5.abs + t.vs5_by3.abs + t.vs5_by1.abs).to be < x }
        it { expect(t.mb11_by8.abs + t.mb11_by5.abs + t.mb11_by2.abs + t.mb11_by1.abs).to be < x }
        it { expect(t.cf_by9.abs + t.cf_by5.abs + t.cf_by3.abs + t.cf_by1.abs).to be < x }
      end

      context 'Total number of packs less than or equal to' do
        next unless x > 7

        it "#{x / 3} for VS5" do
          expect(t.vs5_by5.abs + t.vs5_by3.abs + t.vs5_by1.abs).to be <= x / 3
        end

        next unless x > 4

        it "#{x / 2} for MB11" do
          expect(t.mb11_by8.abs + t.mb11_by5.abs + t.mb11_by2.abs + t.mb11_by1.abs).to be <= x / 2
        end

        next unless x > 7

        it "#{x / 3} for CF" do
          expect(t.cf_by9.abs + t.cf_by5.abs + t.cf_by3.abs + t.cf_by1.abs).to be <= x / 3
        end
      end

      context 'Total number of packs greater than or equal to' do
        next unless x > 7

        it "#{x / 5} for VS5" do
          expect(t.vs5_by5.abs + t.vs5_by3.abs + t.vs5_by1.abs).to be >= x / 5
        end

        next unless x > 4

        it "#{x / 8} for MB11" do
          expect(t.mb11_by8.abs + t.mb11_by5.abs + t.mb11_by2.abs + t.mb11_by1.abs).to be >= x / 8
        end

        next unless x > 7

        it "#{x / 9} for CF" do
          expect(t.cf_by9.abs + t.cf_by5.abs + t.cf_by3.abs + t.cf_by1.abs).to be >= x / 9
        end
      end
    end
  end
end
