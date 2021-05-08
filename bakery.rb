# frozen_string_literal: true

# Bakery class for solving Bakery Coding Challenge
class Bakery
  attr_reader :vs5_by3, :vs5_by5, :mb11_by2, :mb11_by5, :mb11_by8, :cf_by3, :cf_by5, :cf_by9, :vs5_by1,
              :mb11_by1, :cf_by1, :vs5, :mb11, :cf

  def initialize(vs5 = 0, mb11 = 0, ncf = 0)
    @vs5 = vs5.to_i
    @vs5_by1 = @vs5_by3 = @vs5_by5 = 0
    @mb11 = mb11.to_i
    @mb11_by1 = @mb11_by2 = @mb11_by5 = @mb11_by8 = 0
    @cf = ncf.to_i
    @cf_by1 = @cf_by3 = @cf_by5 = @cf_by9 = 0
    solve
  end

  # Setter methods will call each solvers
  def vs5=(vs5)
    @vs5 = vs5
    @vs5_by1 = @vs5_by3 = @vs5_by5 = 0
    solve_vs5
  end

  def mb11=(mb11)
    @mb11 = mb11
    @mb11_by1 = @mb11_by2 = @mb11_by5 = @mb11_by8 = 0
    solve_mb11
  end

  def cf=(ncf)
    @cf = ncf
    @cf_by1 = @cf_by3 = @cf_by5 = @cf_by9 = 0
    solve_cf
  end

  def vs5_by_pack
    [@vs5_by5, @vs5_by3, @vs5_by1]
  end

  def mb11_by_pack
    [@mb11_by8, @mb11_by5, @mb11_by2, @mb11_by1]
  end

  def cf_by_pack
    [@cf_by9, @cf_by5, @cf_by3, @cf_by1]
  end

  private

  def solve
    solve_vs5
    solve_mb11
    solve_cf
  end

  # solve_vs5 will check first if @vs5 is divisible by 5
  # IF yes, that means @vs5 / 5  is the most optimal number of packaging
  # in the form of pure pack of 5s
  # ELSE, add a pack of 3 and then check if that makes it divisible by 5 (repeat until divisible by 5)

  def solve_vs5
    if ((@vs5 - @vs5_by3 * 3) % 5).zero?
      @vs5_by5 = (@vs5 - @vs5_by3 * 3) / 5
    elsif (@vs5 - partial_sum_vs5 - 3) >= 0
      @vs5_by3 += 1
      solve_vs5
    else
      @vs5_by1 = (@vs5 - partial_sum_vs5)
    end
  end

  def partial_sum_vs5
    5 * @vs5_by5 + 3 * @vs5_by3
  end

  # solve_mb11 will check first if @mb11 is divisible by 2
  # IF yes, that means (@mb11 / 8) + (@mb11 % 8) / 2  is the most optimal number of packaging
  # in the form of combination of pack of 8s and 2s
  # Note: @mb11_by2's max amount is 3, cause otherwise it'll turn into 1 pack of 8 instead
  # ELSE, add a pack of 5 and then check if that makes it divisible by 2 (repeat until divisible by 2)

  def solve_mb11
    if @mb11 < 4
      @mb11_by2 = @mb11 / 2
      @mb11_by1 = @mb11 % 2
      return
    end
    if ((@mb11 - @mb11_by5 * 5) % 2).zero?
      @mb11_by8 = (@mb11 - @mb11_by5 * 5) / 8
      @mb11_by2 = ((@mb11 - @mb11_by5 * 5) % 8) / 2
    else
      @mb11_by5 += 1
      solve_mb11
    end
  end

  # solve_cf will check first if @cf is divisible by 3
  # IF yes, that means (@cf / 9) + (@cf % 9) / 3  is the most optimal number of packaging
  # in the form of combination of pack of 9s and 3s
  # Note: @cf_by3's max amount is 2, cause otherwise it'll turn into 1 pack of 9 instead
  # ELSE, add a pack of 5 and then check if that makes it divisible by 3 (repeat until divisible by 3)

  def solve_cf
    if ((@cf - @cf_by5 * 5) % 3).zero?
      @cf_by9 = (@cf - @cf_by5 * 5) / 9
      @cf_by3 = ((@cf - @cf_by5 * 5) % 9) / 3
    elsif (@cf - partial_sum_cf) >= 5
      @cf_by5 += 1
      solve_cf
    else
      @cf_by3 += (@cf - partial_sum_cf) / 3
      @cf_by1 = (@cf - partial_sum_cf)
    end
  end

  def partial_sum_cf
    9 * cf_by9 + 5 * cf_by5 + 3 * cf_by3
  end
end
