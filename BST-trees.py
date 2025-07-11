import random
import time

# Selection Sort
def selection_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(n - 1):
        min_idx = i
        for k in range(i + 1, n):
            comparisons += 1
            if A[k] < A[min_idx]:
                min_idx = k
        A[i], A[min_idx] = A[min_idx], A[i]
    return A, comparisons

# Insertion Sort
def insertion_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(1, n):
        item_to_insert = A[i]
        j = i - 1
        while j >= 0:
            comparisons += 1
            if A[j] > item_to_insert:
                A[j + 1] = A[j]
                j -= 1
            else:
                break
        A[j + 1] = item_to_insert
    return A, comparisons

# Merge Sort
def merge_sort(A):
    comparisons = 0
    def merge(A, low, middle, high):
        nonlocal comparisons
        i1 = low
        i2 = middle + 1
        temp = []

        while i1 <= middle and i2 <= high:
            comparisons += 1
            if A[i1] < A[i2]:
                temp.append(A[i1])
                i1 += 1
            else:
                temp.append(A[i2])
                i2 += 1

        while i1 <= middle:
            comparisons += 1
            temp.append(A[i1])
            i1 += 1

        while i2 <= high:
            comparisons += 1
            temp.append(A[i2])
            i2 += 1

        for i in range(len(temp)):
            A[low + i] = temp[i]

    def merge_sort_helper(A, low, high):
        nonlocal comparisons
        if low < high:
            middle = (low + high) // 2
            merge_sort_helper(A, low, middle)
            merge_sort_helper(A, middle + 1, high)
            merge(A, low, middle, high)

    merge_sort_helper(A, 0, len(A) - 1)
    return A, comparisons

# Quick Sort
def quick_sort(A):
    comparisons = 0
    def partition(A, low, high):
        nonlocal comparisons
        pivot = A[high]
        i = low - 1
        for j in range(low, high):
            comparisons += 1
            if A[j] <= pivot:
                i += 1
                A[i], A[j] = A[j], A[i]
        A[i + 1], A[high] = A[high], A[i + 1]
        return i + 1

    def quick_sort_helper(A, low, high):
        nonlocal comparisons
        if low < high:
            pi = partition(A, low, high)
            quick_sort_helper(A, low, pi - 1)
            quick_sort_helper(A, pi + 1, high)

    quick_sort_helper(A, 0, len(A) - 1)
    return A, comparisons

# Heap Sort
def heapify(A, n, i):
    comparisons = 0
    largest = i
    l = 2 * i + 1
    r = 2 * i + 2

    if l < n and A[l] > A[largest]:
        largest = l
        comparisons += 1

    if r < n and A[r] > A[largest]:
        largest = r
        comparisons += 1

    if largest != i:
        A[i], A[largest] = A[largest], A[i]
        comparisons += 1
        comparisons += heapify(A, n, largest)

    return comparisons

def heap_sort(A):
    n = len(A)
    comparisons = 0

    for i in range(n // 2 - 1, -1, -1):
        comparisons += heapify(A, n, i)

    for i in range(n - 1, 0, -1):
        A[i], A[0] = A[0], A[i]
        comparisons += heapify(A, i, 0)

    return A, comparisons

# Bubble Sort
def bubble_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(n - 1):
        for k in range(n - 1):  # Always go from 0 to n-2
            comparisons += 1
            if A[k] > A[k + 1]:
                A[k], A[k + 1] = A[k + 1], A[k]
    return A, comparisons

# Obs1 Bubble Sort
def obs1_bubble_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(1, n):
        for k in range(n - i):  # Only compare up to n - i
            comparisons += 1
            if A[k] > A[k + 1]:
                A[k], A[k + 1] = A[k + 1], A[k]
    return A, comparisons

# Obs2 Bubble Sort
def obs2_bubble_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(n - 1):
        swapped = False
        for k in range(n - i - 1):
            comparisons += 1
            if A[k] > A[k + 1]:
                A[k], A[k + 1] = A[k + 1], A[k]
                swapped = True
        if not swapped:
            break
    return A, comparisons

def obs3_bubble_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(n - 1):
        swapped = False
        for k in range(n - i - 1):  # Like obs1: avoid scanning sorted end
            comparisons += 1
            if A[k] > A[k + 1]:
                A[k], A[k + 1] = A[k + 1], A[k]
                swapped = True
        if not swapped:  # Like obs2: stop early if no swaps
            break
    return A, comparisons

# Sink Down Sort
def sink_down_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(1, n):
        for k in range(n - 1, 0, -1):  # Always scan full array backwards
            comparisons += 1
            if A[k - 1] > A[k]:
                A[k - 1], A[k] = A[k], A[k - 1]
    return A, comparisons

# BDB Sort
def bdb_sort(A):
    n = len(A)
    comparisons = 0
    for i in range(n // 2):
        swapped = False

        for k in range(i, n - i - 1):
            comparisons += 1
            if A[k] > A[k + 1]:
                A[k], A[k + 1] = A[k + 1], A[k]
                swapped = True

        for k in range(n - i - 2, i - 1, -1):
            comparisons += 1
            if A[k] > A[k + 1]:
                A[k], A[k + 1] = A[k + 1], A[k]
                swapped = True
        if not swapped:
            break
    
    return A, comparisons


# Function to run the algorithm and record time and comparisons
def run_algorithm(algorithm, A):
    start_time = time.perf_counter()
    sorted_A, comparisons = algorithm(A)
    end_time = time.perf_counter()
    run_time = (end_time - start_time) * 1000  # Convert to ms
    return comparisons, run_time

def print_table_heading():
    print("\nSorting Algorithm  | Array Size | Num. of Comparisons    | Run time (ms)")
    print("-" * 80)

# Main Menu
def main_menu():
    algorithms = {
        "1": ("Selection Sort", selection_sort),
        "2": ("Insertion Sort", insertion_sort),
        "3": ("Merge Sort", merge_sort),
        "4": ("Quick Sort", quick_sort),
        "5": ("Heap Sort", heap_sort),
        "6": ("Bubble Sort", bubble_sort),
        "7": ("Obs1 Bubble Sort", obs1_bubble_sort),
        "8": ("Obs2 Bubble Sort", obs2_bubble_sort),
        "9": ("Obs3 Bubble Sort", obs3_bubble_sort),
        "A": ("Sink Down Sort", sink_down_sort),
        "B": ("BDB Sort", bdb_sort)
    }

    while True:
        print("\nMain Menu:")
        print("1. Test an individual sorting algorithm")
        print("2. Test multiple sorting algorithms")
        print("3. Exit")
        
        choice = input("Enter your choice: ").strip()

        if choice == "1":
            print("\nChoose a sorting algorithm to test:")
            for key, value in algorithms.items():
                print(f"{key}. {value[0]}")
            algorithm_choice = input("Enter your choice: ").strip()

            if algorithm_choice in algorithms:
                algorithm_name, algorithm_function = algorithms[algorithm_choice]
                n = int(input("Enter the size of the array: "))
                A = [random.randint(1, n * 10) for _ in range(n)]
                comparisons, run_time = run_algorithm(algorithm_function, A)

                print("\nSorting algorithm name   | Array size | Num. of Comparisons | Run time (in ms.)")
                print("----------------------------------------------------------------------")
                print(f"{algorithm_name:<24} | {n:<10} | {comparisons:<20} | {run_time:.4f}")

            else:
                print("Invalid choice, please try again.")

        elif choice == "2":
            n = int(input("Enter the size of the array: "))
            A = [random.randint(1, n * 10) for _ in range(n)]

            print_table_heading()

            for key, value in algorithms.items():
                algorithm_name, algorithm_function = value
                comparisons, run_time = run_algorithm(algorithm_function, A.copy())
                print(f"{algorithm_name:<20}| {n:<10} | {comparisons:<20}   | {run_time:.4f} ms")

        elif choice == "3":
            print("Exiting...")
            break

        else:
            print("Invalid choice, please try again.")

if __name__ == "__main__":
    main_menu()

#TutorialsPoint. (2023, January 24). Align text strings using Python. https://www.tutorialspoint.com/how-to-align-text-strings-using-python
