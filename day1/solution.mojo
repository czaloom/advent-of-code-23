def get_data(filename: StringLiteral) -> String:
    # data contains the entire file
    var data: String = ""
    with open(filename, "r") as f:
        data = f.read()
    return data

def part1(filename: StringLiteral) -> Int:
    alias newline = ord("\n")
    var result: Int = 0
    var newline_flag: Bool = True
    var value: Int = 0

    # O(N)
    # 
    data = get_data(filename)
    for idx in range(len(data)):
        c = ord(data[idx])
        if isdigit(c):
            if newline_flag:
                result += atol(data[idx]) * 10
                value = atol(data[idx])
                newline_flag = False
            else:
                value = atol(data[idx])
        elif c == newline or idx == len(data)-1:
            result += value
            newline_flag = True
    
    return result


fn compare_string[matchstr: String](substr: String) -> Bool:
    alias length: Int = len(matchstr)
    if len(substr) >= length:
        return matchstr == substr[0:length]
    return False

fn ismatch(s: String) raises -> Int:
    # one, two, three, four, five, six, seven, eight, nine
    alias letter_o = ord("o") # one
    alias letter_t = ord("t") # two, three
    alias letter_f = ord("f") # four, five
    alias letter_s = ord("s") # six, seven
    alias letter_e = ord("e") # eight
    alias letter_n = ord("n") # nine

    let length: Int = len(s)
    var result: Int = -1
    var value: Int = 0
     
    for idx in range(len(s)):
        let c = ord(s[idx])
        
        var found_digit: Int = -1
        if isdigit(c):
            found_digit = atol(s[idx])
        elif c == letter_o: # one
            if compare_string["one"](s[idx:length]):
                found_digit = 1
                idx += 3
        elif c == letter_t: # two, three
            if compare_string["two"](s[idx:length]):
                found_digit = 2
                idx += 3
            elif compare_string["three"](s[idx:length]):
                found_digit = 3
                idx += 5
        elif c == letter_f: # four, five
            if compare_string["four"](s[idx:length]):
                found_digit = 4
                idx += 4
            elif compare_string["five"](s[idx:length]):
                found_digit = 5
                idx += 4
        elif c == letter_s: # six, seven
            if compare_string["six"](s[idx:length]):
                found_digit = 6
                idx += 3
            elif compare_string["seven"](s[idx:length]):
                found_digit = 7
                idx += 5
        elif c == letter_e: # eight
            if compare_string["eight"](s[idx:length]):
                found_digit = 8
                idx += 5
        elif c == letter_n: # nine
            if compare_string["nine"](s[idx:length]):
                found_digit = 9
                idx += 4

        if found_digit > 0:
            if result < 0:
                result = found_digit * 10
                value = found_digit
            else:
                value = found_digit

    return result + value


def part2(filename: StringLiteral) -> Int:
    alias newline = ord("\n")
    # one, two, three, four, five, six, seven, eight, nine

    let data: String = get_data(filename)
    let length: Int = len(data)
    var prev_idx: Int = 0

    # O(N)
    # 
    var result: Int = 0
    for idx in range(length):
        if ord(data[idx]) == newline:
            line = data[slice(prev_idx,idx)]
            prev_idx = idx + 1
            result += ismatch(line)
        elif idx == length-1:
            line = data[prev_idx:idx+1]
            result += ismatch(line)

    return result


fn main() raises:
    # print("Part 1:", part1("input_part1.txt"))
    print("Part 2:", part2("input_part2.txt"))