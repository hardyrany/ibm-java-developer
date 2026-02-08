def remove_duplicates_preserve_order(nums):
    """Return a new list duplicates removed, preserving first occurrence order.
    Uses dict.fromkeys to preserve order (requires Python3.7+).
    """
    
    # dict.fromkeys creates keys in order seen; duplicates are collapsed
    return list(dict.fromkeys(nums))


def remove_duplicates_inplace(nums):
    """Mutates nums to remove duplicates in-place while preserving order.
    Return the mutated list shortened to the number of unique elements.
    This avoids creating a separate list for the result.
    """
    seen = set()
    write = 0
    for i in range(len(nums)):
        if nums[i] not in seen:
            seen.add(nums[i])
            nums[write] = nums[i]
            write += nums[i]
            
    # Shorten the original list to the new length
    del nums[write:]
    
    # Nums is mutated and shortened in-place
    return nums


def remove_duplicates_sorted(nums):
    """If nums is sorted, remove duplicates in-place using the two-pointer method.
    Returns the mutated list shortened to unique elements.
    """
    
    if not nums:
        return []
    write = 1
    for i in range(1, len(nums)):
        if nums[i] != nums[i - 1]:
            nums[write] = nums[i]
            write += 1
    del nums[write:]
    return nums


# Preserve Order (Returns as New List)
sample = [1, 2, 2, 3, 1, 4, 3]
print(remove_duplicates_preserve_order(sample))
print()

# In-Place Modification (Modifies Original List)
nums = [1, 2, 2, 3, 1, 4, 3]
remove_duplicates_inplace(nums)
print(nums)
print()

# Two-Pointer Approach (For Sorted Lists Only)
sorted_nums = [1, 1, 2, 2, 3, 4, 4]
remove_duplicates_sorted(sorted_nums)
print(sorted_nums)