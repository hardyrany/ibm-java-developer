def find_largest(arr):
    """Return the largest value in a non-empty list arr
    Args:
        arr (list): A non-empty list of numbers.
    Returns:
        ValueError: If arr is empty
    """
    
    if not arr:
        raise ValueError('The list must not be empty.')
    
    # Start with the first element as the current largest
    largest = arr[0]
    
    # Check remaining elements (start from index 1)
    for num in arr[1:]:
        if num > largest:
            largest = num
    return largest

# Example usage
sample = [3, 1, 4, 5, -2, 9]

print('Largest value:', find_largest(sample))