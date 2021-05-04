class Bakery
  attr_accessor :vs5by3, :vs5by5, :mb11by2, :mb11by5, :mb11by8, :cfby3, :cfby5, :cfby9, :vs5, :mb11, :cf, :vs5by1, :mb11by1, :cfby1

  def initialize(vs5 = 0, mb11 = 0, cf = 0)
    @vs5 = vs5.to_i
    @vs5by1 = 0
    @vs5by3 = 0
    @vs5by5 = 0
    @mb11 = mb11.to_i
    @mb11by1 = 0
    @mb11by2 = 0
    @mb11by5 = 0
    @mb11by8 = 0
    @cf = cf.to_i
    @cfby1 = 0
    @cfby3 = 0
    @cfby5 = 0
    @cfby9 = 0
    self.solve
  end

  def print_soln
    p "#{@vs5}  VS5  (5/3/1)     = [ #{@vs5by5}, #{@vs5by3}, #{@vs5by1} ] = #{5 * @vs5by5 + 3 * @vs5by3 + @vs5by1}"
    p "#{@mb11} MB11 (8/5/2/1)   = [ #{@mb11by8}, #{@mb11by5}, #{@mb11by2}, #{@mb11by1} ] = #{8 * @mb11by8 + 5 * @mb11by5 + 2 * @mb11by2 + @mb11by1}"
    p "#{@cf}   CF   (9/5/3/1)   = [ #{@cfby9}, #{@cfby5}, #{@cfby3}, #{@cfby1} ] = #{9 * @cfby9 + 5 * @cfby5 + 3 * @cfby3 + @cfby1}"
  end

  private
  
  def solve
    if @vs5 > 7 || @vs5 == 5
        self.solve_VS5
    else
        @vs5by3 = @vs5 / 3
        @vs5by1 = @vs5 % 3
    end

    if @mb11 > 4
        self.solve_MB11 
    else
        @mb11by2 = @mb11 / 2
        @mb11by1 = @mb11 % 2
    end

    if @cf > 7 || @cf == 5
        self.solve_CF 
    else
        @cfby3 = @cf / 3
        @cfby1 = @cf % 3
    end
  end

  def solve_VS5
    # Minimize @vs5by3 + @vs5by5
    # Given 3 * @vs5by3 + 5* @vs5by5 = @vs5
    if (((@vs5 - @vs5by3 * 3) / 5.0) % 1 == 0)
      @vs5by5 = (@vs5 - @vs5by3 * 3) / 5
    else
      @vs5by3 = @vs5by3 + 1
      self.solve_VS5
    end
  end

  def solve_MB11
    # Minimize @mb11by2 + @mb11by5 + @mb11by8
    # Given 2 * @mb11by2 + 5 * @mb11by5 + 8 * @mb11by8 = @mb11
    if (((@mb11 - @mb11by5 * 5) / 2.0) % 1 == 0)
      @mb11by8 = (@mb11 - @mb11by5 * 5) / 8
      @mb11by2 = ((@mb11 - @mb11by5 * 5) % 8) / 2
    else
      @mb11by5 = @mb11by5 + 1
      self.solve_MB11
    end
  end

  def solve_CF
    # Minimize @cfby3 + @cfby5 + @cfby9
    # Given 3 * @cfby3 + 5 * @cfby5 + 9 * @cfby9 = @cf
    if (((@cf - @cfby5 * 5) / 3.0) % 1 == 0)
      @cfby9 = (@cf - @cfby5 * 5) / 9
      @cfby3 = ((@cf - @cfby5 * 5) % 9) / 3
    else
      @cfby5 = @cfby5 + 1
      self.solve_CF
    end
  end

end

