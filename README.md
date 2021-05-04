# Hi there 👋

## Instructions how to use

### Instance Initialization
Initialize an instance of ``` Bakery ``` class.
```
bakery = Bakery.new()
```

### Setting orders

Set orders simultaneously by initialization

```
b = Bakery.new(10, 14, 13)
```

Set an order manually
```
bakery.vs5 = 10
bakery.mb11 = 14
bakery.cf = 13
```
### Getting pack amount

You can call any of ```vs5_by_pack```, ```mb11_by_pack```, ```cf_by_pack``` to get the respective amount of packs
```
bakery.vs5_by_pack # [2, 0, 0] means 2 x 5s, 0 x 3s, 0 x 1s
bakery.mb11_by_pack # [1, 0, 3, 0] means 1 x 8s, 0 x 5s, 3 x 2s, 0 x 1s
bakery.cf_by_pack # [0, 2, 1, 0] means 0 x 9s, 2 x 5s, 1 x 3s, 0 x 1s
```

Similarly you can get each of the pack amount individually by

```
bakery.vs5_by_5 # 2
bakery.vs5_by_3 # 0
bakery.vs5_by_1 # 0
```

### Example
See ```example.rb``` for more info.