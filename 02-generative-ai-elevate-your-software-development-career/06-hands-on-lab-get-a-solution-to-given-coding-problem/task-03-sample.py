def unique_sorted_countries(countries):
    """Return alphabetically sorted list of unique country names.
    This function removes duplicates from the input list and returns
    the result sorted in the ascending alphabetical order.
    It uses only basic Python features: lists, sets, and built-in sorted().    
    """
    
    if not isinstance(countries, list):
        raise TypeError('Input must be a list of countries names.')
    
    # Remove duplicates by converting to a set, then sort the unique items.
    unique_sorted = sorted(set(countries))
    return unique_sorted

# Example usage with ten country names (with duplicates)
countries = [
    'Canada', 'Brazil', 'India', 'United States', 'Canada',
    'Mexico', 'Japan', 'Germany', 'France', 'India'
]

print('Input list(with duplicates):', countries)
result = unique_sorted_countries(countries)
print()
print('Unique, alphabetically sorted:', result)