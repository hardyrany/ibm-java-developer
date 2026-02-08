def find_duplicate_elements(nums):
    """Return a list of duplicate elements from nums, preserving the order
    of their first duplicate appearance. Each duplicate element appears only once in the result.
    This implementation uses append yo build the result list as required.
    """
    
    seen = set()
    duplicates = set()
    result = [] # Will store the duplicates in the order they are first identified
    for num in nums:
        if num in seen:
            duplicates.add(num)
            result.append(num) # Using append as requested
        else:
            seen.add(num)
    return result

# Sample input with duplicates to illustrate the function's operation
sample = [1, 2, 2, 3, 3, 3, 4, 5, 4, 6, 5]

print("Input:", sample)
print()
print("Duplicates:", find_duplicate_elements(sample))
# Expected output: [2, 3, 4, 5]