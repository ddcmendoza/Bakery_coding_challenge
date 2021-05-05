# frozen_string_literal: true

require_relative 'bakery'

# Example with order of 10 VS5, 14 MB11, and 13 CF
b = Bakery.new(10, 14, 13)

p b.vs5_by_pack # [2, 0, 0] means 2 x 5s, 0 x 3s, 0 x 1s
p b.mb11_by_pack # [1, 0, 3, 0] means 1 x 8s, 0 x 5s, 3 x 2s, 0 x 1s
p b.cf_by_pack # [0, 2, 1, 0] means 0 x 9s, 2 x 5s, 1 x 3s, 0 x 1s

# Similarly you can access the values by pack size

p b.vs5_by5 # 2
p b.vs5_by3 # 0
p b.vs5_by1 # 0

p b.mb11_by8 # 1
p b.mb11_by5 # 0
p b.mb11_by2 # 3
p b.mb11_by1 # 0

p b.cf_by9 # 0
p b.cf_by5 # 2
p b.cf_by3 # 1
p b.cf_by1 # 0

# Example with no orders
bakery = Bakery.new

p bakery.vs5_by_pack  # [0, 0, 0]
p bakery.mb11_by_pack # [0, 0, 0, 0]
p bakery.cf_by_pack # [0, 0, 0, 0]

# Manually set number of orders
bakery.vs5 = 10
p bakery.vs5_by_pack # [2, 0, 0]

# Once you manually set an order, it will automatically solve the by pack values
bakery.vs5 = 20
p bakery.vs5_by_pack # [4, 0, 0]
