require "byebug"

def no_dupes?(arr)
    no_dupes = []
    popped = []

    while arr.length > 0
        el = arr.pop()
        if arr.include?(el) || popped.include?(el)
            popped << el
        else
            no_dupes << el
        end
    end

    no_dupes
end

# Examples
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []


def no_consecutive_repeats?(arr)

    i = 0
    while i < arr.length
        if arr[i] == arr[i+1]
            return false
        end
        i += 1
    end

    true
end

# Examples
# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true


def char_indices(str)
    h = Hash.new { |h, k| h[k] = [] }

    str.each_char.with_index do |char, i|
        h[char] << i
    end

    h
end


# # Examples
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}


def longest_streak(str)
    longest_streak = str[0]

    i = 0
    while i < str.length
        # debugger
        char = str[i]
        streak = [char]
        # p "outer i"
        # p i
        # p char
        while char == str[i + 1]
            # p "inner i"
            # p i
            streak.push(char)
            i += 1
        end

        if streak.length >= longest_streak.length
            longest_streak = streak
        end
        i += 1
    end

    longest_streak.join("")
end

# Examples
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'
def is_prime?(num)
    num < 2 ? false : (2...num).none? {|factor| num % factor == 0 }
end


def bi_prime?(num)
    (2..num/2).each do |factor1|
        if num % factor1 == 0
            factor2 = num / factor1
            return true if is_prime?(factor1) && is_prime?(factor2)
        end
    end

    false
end

# Examples
# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false


def vigenere_cipher(word, arr)
    alphabet = ('a'..'z').to_a
    len = arr.length
    vi_word = ''

    word.each_char.with_index do |char, i|
        idx = alphabet.index(char)
        key = arr[i % len]

        vi_word += alphabet[(idx + key) % 26]
    end

    vi_word
end

# Message:  b a n a n a s i n p a j a m a s
# Keys:     1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# Result:   c c q b p d t k q q c m b o d t

# Examples
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"


# Write a method vowel_rotate(str) that accepts a string as an arg and returns the string where every vowel is replaced with the vowel that appears before it sequentially in the original string. The first vowel of the string should be replaced with the last vowel.
def vowel_rotate(str)
    vowels = 'aeiou'
    first_index = str.length
    prev_vowel = 'z'
    last_vowel = 'z'

    (0...str.length).each do |i|
        char = str[i]
        if vowels.include?(char)
            last_vowel = char
            first_index = [first_index, i].min
            if i != first_index
                str[i] = prev_vowel
            end
            prev_vowel = last_vowel
        end
    end

    str[first_index] = last_vowel
    str
end



# # Examples
# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"


# Proc Problems

# String#select
# Extend the string class by defining a String#select method that accepts a block.
# The method should return a new string containing characters of the original string that return true when passed into the block.
# If no block is passed, then return the empty string. Do not use the built-in Array#select in your solution.
class String
    def select(&prc)
        filtered = ""
        return filtered if prc == nil

        (0...self.length).each do |i|
            filtered += self[i] if prc.call(self[i])
        end

        filtered
    end
end


# Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# String#map!
# Extend the string class by defining a String#map! method that accepts a block.
# The method should modify the existing string by replacing every character with the result of calling the block, passing in the original character and it's index.
# Do not use the built-in Array#map or Array#map! in your solution.
class String
    def map!(&prc)
        (0...self.length).each do |i|
            self[i] = prc.call(self[i], i)
        end
        self
    end
end


# # Examples
# word_1 = "Lovelace"
# word_1.map! do |ch|
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"


# Recursion Problems

# Write a method multiply(a, b) that takes in two numbers and returns their product.
def multiply(a, b)
    direction = b / b.abs

    return a * direction if b == direction
    a * direction + multiply(a, b - direction)
end

# You must solve this recursively (no loops!)
# You must not use the multiplication (*) operator
# Examples
# p multiply(5, 3)        # => 15
# p multiply(3, 5)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18


# The Lucas Sequence is a sequence of numbers. The first number of the sequence is 2.
# The second number of the Lucas Sequence is 1.
# To generate the next number of the sequence, we add up the previous two numbers.
# For example, the first six numbers of the sequence are: 2, 1, 3, 4, 7, 11, ...
# Write a method lucasSequence that accepts a number representing a length as an arg.
# The method should return an array containing the Lucas Sequence up to the given length.
# Solve this recursively.
def lucas_sequence(len)
    if len == 0
        return []
    elsif len == 1
        return [2]
    elsif len == 2
        return [2, 1]
    end

    # Recursive Case
    last_seq = lucas_sequence(len - 1)
    el = last_seq[-1] + last_seq[-2]
    last_seq.concat([el])
    last_seq
end


# Examples
# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]



# The Fundamental Theorem of Arithmetic states that every positive integer is either a prime or can be represented as a product of prime numbers.
# Write a method prime_factorization(num) that accepts a number and returns an array representing the prime factorization of the given number. T
# his means that the array should contain only prime numbers that multiply together to the given num.
# The array returned should contain numbers in ascending order. Do this recursively.

def prime_factorization(num)
    return [num] if is_prime?(num)

    seq = []

    (2...num).each do |i|
        if num % i == 0 && is_prime?(i)
            seq.push(i)
            num = num / i
            seq.concat(prime_factorization(num))
            break
        end
    end

    seq
end


# # Examples
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]
