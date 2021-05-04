# Hi there 👋

## Instructions

### Instance Initialization
Initialize an instance of ``` Bakery ``` class.
```ruby
bakery = Bakery.new()
```

### Setting orders

Set orders simultaneously by initialization

```ruby
b = Bakery.new(10, 14, 13) # for 10 VS5, 14 MB11, and 13 CF order
```

Set an order manually
```ruby
bakery.vs5 = 10
bakery.mb11 = 14
bakery.cf = 13
```
Note: Setting an order manually will automatically update the number of packs.

So for example
```ruby
bakery.vs5 = 10 
bakery.vs5_by_pack # [2, 0, 0]


bakery.vs5 = 20
bakery.vs5_by_pack # [4, 0, 0]
```

### Getting pack amount

You can call any of ```vs5_by_pack```, ```mb11_by_pack```, ```cf_by_pack``` to get the respective amount of packs
```ruby
bakery.vs5_by_pack # [2, 0, 0] means 2 x 5s, 0 x 3s, 0 x 1s
bakery.mb11_by_pack # [1, 0, 3, 0] means 1 x 8s, 0 x 5s, 3 x 2s, 0 x 1s
bakery.cf_by_pack # [0, 2, 1, 0] means 0 x 9s, 2 x 5s, 1 x 3s, 0 x 1s
```

Similarly you can get each of the pack amount individually by

```ruby
bakery.vs5_by_5 # 2
bakery.vs5_by_3 # 0
bakery.vs5_by_1 # 0
```

### Example
See [```example.rb```](./example.rb) for more info.
