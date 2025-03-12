using Distributed
using Base.Threads
using Primes
using Base.Iterators  # Importing Iterators

function is_prime(n::Int)
    if n < 2
        return false
    end
    for i in 2:isqrt(n)
        if n % i == 0
            return false
        end
    end
    return true
end

# Function to check primes in parallel and return all primes found
function parallel_prime_check(numbers)
    chunks = Iterators.partition(numbers, length(numbers) ÷ Threads.nthreads())  # Split numbers into chunks
    tasks = map(chunks) do chunk
        Threads.@spawn begin
            return filter(is_prime, chunk)  # Return only primes from the chunk
        end
    end
    chunk_primes = fetch.(tasks)  # Fetch all prime lists from tasks
    return vcat(chunk_primes...)  # Concatenate all lists of primes into one list
end

# Main function to check primes efficiently
function best_optimization(numbers)
    return parallel_prime_check(numbers)  # Get all primes in parallel
end

numbers = 1:1000000  # Range of numbers to check for primes

# Run the function and time the execution
@time found_primes = best_optimization(numbers)
println("Number of primes found: ", length(found_primes))  # Output the number of primes found
