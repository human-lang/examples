# Uses a binary search algorithm to locate a value in the specified array.
binary_search = (items, value) ->

  start = 0
  stop  = items.length - 1
  pivot = Math.floor (start + stop) / 2

  while items[pivot] isnt value and start < stop

    # Adjust the search area.
    stop  = pivot - 1 if value < items[pivot]
    start = pivot + 1 if value > items[pivot]

    # Recalculate the pivot.
    pivot = Math.floor (stop + start) / 2

  # Make sure we've found the correct value.
  if items[pivot] is value then pivot else -1


# Test the function.
console.log  2 is binary_search [10, 20, 30, 40, 50], 30
console.log  4 is binary_search [-97, 35, 67, 88, 1200], 1200
console.log  0 is binary_search [0, 45, 70], 0
console.log -1 is binary_search [0, 45, 70], 10


# Haskell 二分查找。
"""
binarySearch :: Integral a => (a -> Ordering) -> (a, a) -> Maybe a
binarySearch p (low,high)
  | high < low = Nothing
  | otherwise =
      let mid = (low + high) `div` 2 in
      case p mid of
        LT -> binarySearch p (low, mid-1)
        GT -> binarySearch p (mid+1, high)
        EQ -> Just mid
"""
