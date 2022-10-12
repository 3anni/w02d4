# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array.
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowels?(word1, word2)
    vowels = ['a', 'e', 'i', 'o', 'u']

    word1.each_char do |char|
        idx = vowels.index(char)
        if idx != nil
            vowels.delete_at(idx)
        end
    end

    word2.each_char do |char|
        idx = vowels.index(char)
        if idx != nil
            vowels.delete_at(idx)
        end
    end

    vowels.length == 0
end

def all_vowel_pairs(words)
    arr = []

    (0...words.length - 1).each do |i|
        (i+1...words.length).each do |j|
            word1 = words[i]
            word2 = words[j]
            if all_vowels?(word1, word2)
                arr.push(word1 + " " + word2)
            end
        end
    end

    arr
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    (2...num).any? { |factor| num % factor == 0 }
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    pairs = []
    bigrams.select { |bigram| str.include?(bigram)}
    # i = 0
    # while i < str.length - 1
    #     pair = str[i..i+1]
    #     pairs.push(pair)
    #     i += 1
    # end
end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        # p prc.call(k, v)
        self.select { |k, v| prc != nil ? prc.call(k, v) : (k == v)}
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        subs = []

        (0...self.length).each do |start_idx|
            (start_idx...self.length).each do |end_idx|
                subs << self[start_idx..end_idx]
            end
        end


        if length.nil?
            subs
        else
            subs.select { |str| str.length == length}
        end

        # (0...self.length).each do |i|
        #     if length == nil
        #         (i...self.length).each do |j|
        #             subs << self[i..j]
        #         end
        #     else
        #         if self.length - i - length >= 0
        #             subs << self[i..i + length - 1]
        #         end
        #     end
        # end

        # subs
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        alphabet = ('a'..'z').to_a

        self.split("").map{ |char| alphabet[(alphabet.index(char) + num) % 26] }.join("")
    end
end
