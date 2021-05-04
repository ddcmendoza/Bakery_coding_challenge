# frozen_string_literal: true

# Bakery class for solving Bakery Coding Challenge
class Bakery
  attr_reader :vs5_by_3, :vs5_by_5, :mb11_by_2, :mb11_by_5, :mb11_by_8, :cf_by_3, :cf_by_5, :cf_by_9, :vs5_by_1,
              :mb11_by_1, :cf_by_1
  attr_accessor :vs5, :mb11, :cf

  def initialize(vs5 = 0, mb11 = 0, ncf = 0)
    @vs5 = vs5.to_i
    @vs5_by_1 = @vs5_by_3 = @vs5_by_5 = 0
    @mb11 = mb11.to_i
    @mb11_by_1 = @mb11_by_2 = @mb11_by_5 = @mb11_by_8 = 0
    @cf = ncf.to_i
    @cf_by_1 = @cf_by_3 = @cf_by_5 = @cf_by_9 = 0
    solve
  end

  # Setter methods will call each solvers
  def vs5=(vs5)
    @vs5 = vs5
    solve_vs5
  end

  def mb11=(mb11)
    @mb11 = mb11
    solve_mb11
  end

  def cf=(ncf)
    @cf = ncf
    solve_cf
  end

  def vs5_by_pack
    [@vs5_by_5, @vs5_by_3, @vs5_by_1]
  end

  def mb11_by_pack
    [@mb11_by_8, @mb11_by_5, @mb11_by_2, @mb11_by_1]
  end

  def cf_by_pack
    [@cf_by_9, @cf_by_5, @cf_by_3, @cf_by_1]
  end

  private

  def solve
    if @vs5 >= 5
      solve_vs5
    else
      @vs5_by_3 = @vs5 / 3
      @vs5_by_1 = @vs5 % 3
    end

    if @mb11 > 4
      solve_mb11
    else
      @mb11_by_2 = @mb11 / 2
      @mb11_by_1 = @mb11 % 2
    end

    if @cf >= 5
      solve_cf
    else
      @cf_by_3 = @cf / 3
      @cf_by_1 = @cf % 3
    end
  end

  # solve_vs5 will check first if @vs5 is divisible by 5
  # IF yes, that means @vs5 / 5  is the most optimal number of packaging
  # in the form of pure pack of 5s
  # ELSE, add a pack of 3 and then check if that makes it divisible by 5 (repeat until divisible by 5)

  def solve_vs5
    if (((@vs5 - @vs5_by_3 * 3) / 5.0) % 1).zero?
      @vs5_by_5 = (@vs5 - @vs5_by_3 * 3) / 5
    else
      @vs5_by_3 += 1
      solve_vs5
    end
  end

  # solve_mb11 will check first if @mb11 is divisible by 2
  # IF yes, that means (@mb11 / 8) + (@mb11 % 8) / 2  is the most optimal number of packaging
  # in the form of combination of pack of 8s and 2s
  # Note: @mb11_by_2's max amount is 3, cause otherwise it'll turn into 1 pack of 8 instead
  # ELSE, add a pack of 5 and then check if that makes it divisible by 2 (repeat until divisible by 2)

  def solve_mb11
    if (((@mb11 - @mb11_by_5 * 5) / 2.0) % 1).zero?
      @mb11_by_8 = (@mb11 - @mb11_by_5 * 5) / 8
      @mb11_by_2 = ((@mb11 - @mb11_by_5 * 5) % 8) / 2
    else
      @mb11_by_5 += 1
      solve_mb11
    end
  end

  # solve_cf will check first if @cf is divisible by 3
  # IF yes, that means (@cf / 9) + (@cf % 9) / 3  is the most optimal number of packaging
  # in the form of combination of pack of 9s and 3s
  # Note: @cf_by_3's max amount is 2, cause otherwise it'll turn into 1 pack of 9 instead
  # ELSE, add a pack of 5 and then check if that makes it divisible by 3 (repeat until divisible by 3)

  def solve_cf
    if (((@cf - @cf_by_5 * 5) / 3.0) % 1).zero?
      @cf_by_9 = (@cf - @cf_by_5 * 5) / 9
      @cf_by_3 = ((@cf - @cf_by_5 * 5) % 9) / 3
    else
      @cf_by_5 += 1
      solve_cf
    end
  end
end
