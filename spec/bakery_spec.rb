require_relative "../bakery"

RSpec.describe Bakery do
  context "Check given test points:" do
    it "10 VS5 should result to 2 x 5" do
      expect(described_class.new(10).vs5by5).to equal(2)
      expect(described_class.new(10).vs5by3).to equal(0)
      expect(described_class.new(10).vs5by1).to equal(0)
    end

    it "14 MB11 should result to 1 x 8, 3 x 2" do
      expect(described_class.new(0, 14).mb11by8).to equal(1)
      expect(described_class.new(0, 14).mb11by5).to equal(0)
      expect(described_class.new(0, 14).mb11by2).to equal(3)
      expect(described_class.new(0, 14).mb11by1).to equal(0)
    end

    it "13 CF should result to 2 x 5, 1 x 3" do
      expect(described_class.new(0, 0, 13).cfby9).to equal(0)
      expect(described_class.new(0, 0, 13).cfby5).to equal(2)
      expect(described_class.new(0, 0, 13).cfby3).to equal(1)
      expect(described_class.new(0, 0, 13).cfby1).to equal(0)
    end
  end

  context "Accept value from 0 - 100" do
    (0..100).each do |x|
      t = described_class.new(x, x, x)
      it "Total should be equal to #{x}" do
        expect(5 * t.vs5by5 + 3 * t.vs5by3 + t.vs5by1).to equal(x)
        expect(8 * t.mb11by8 + 5 * t.mb11by5 + 2 * t.mb11by2 + t.mb11by1).to equal(x)
        expect(9 * t.cfby9 + 5 * t.cfby5 + 3 * t.cfby3 + t.cfby1).to equal(x)
      end
      if x > 2
        it "Total number of package less than #{x}" do
          expect(t.cfby9 + t.cfby5 + t.cfby3 + t.cfby1).to be < x
          expect(t.vs5by5 + t.vs5by3 + t.vs5by1).to be < x
          expect(t.mb11by8 + t.mb11by5 + t.mb11by2 + t.mb11by1).to be < x
        end
      end
    end
  end
end
