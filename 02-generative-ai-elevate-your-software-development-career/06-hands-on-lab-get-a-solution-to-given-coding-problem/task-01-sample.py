def find_min_max(nums):
   
    # Return the minimum values from the nom-empty list nums.
    if not nums:
        raise ValueError('The list must not be empty')
    
    # Initialize min and mas with the first element
    min_val = max_val = nums[0]
   
    # Scan the remaining elements
    for num in nums[1:]:
        if num < min_val:
            min_val = num
        if num > max_val:
            max_val = num
    return min_val, max_val

# Example usage with sa sample list
sample_list = [3, 1, 5, 9, 2, 6, -1, 7]
minimum, maximum = find_min_max(sample_list)

print('Minimum value:', minimum)
print('Maximum value:', maximum)