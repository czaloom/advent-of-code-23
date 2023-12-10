def get_data(filename: StringLiteral) -> String:
    # data contains the entire file
    var data: String = ""
    with open(filename, "r") as f:
        data = f.read()
    return data


def part1(filename: StringLiteral) -> Int:
    alias newline = ord("\n")
    alias colon = ord(":")
    alias space = ord(" ")
    alias letter_r = ord("r")
    alias letter_g = ord("g")
    alias letter_b = ord("b")

    alias max_colors = SIMD[DType.int32, 4](12, 13, 14, 0)

    var result: Int = 0

    var game_id = 0
    var game_colors = SIMD[DType.int32, 4]()

    var state: Int = 0
    var idx: Int = 5
    var idx_cache: Int = idx
    let data = get_data(filename)
    while idx < len(data):

        if ord(data[idx]) == newline:
            idx += 6
            idx_cache = idx
            state = 0

            # add last game
            if game_colors <= max_colors:
                result += game_id
        else:
            if state == 0: # Find game id
                if ord(data[idx]) == colon:
                    game_id = atol(data[idx_cache:idx])
                    state = 1   # proceed to finding max counts
                    idx += 2    # skip space
                    idx_cache = idx
            elif state == 1: # Count colors & find local maximums
                if ord(data[idx]) == space:
                    print(data[idx+1])
                    let newvalue = atol(data[idx_cache:idx])
                    let color_letter = ord(data[idx+1])
                    print(newvalue, chr(color_letter))
                    if (
                        color_letter == letter_r 
                        and newvalue > game_colors[0].to_int()
                    ):
                        game_colors[0] = newvalue
                        idx += 6
                        idx_cache = idx
                    elif (
                        color_letter == letter_g 
                        and newvalue > game_colors[1].to_int()
                    ):
                        game_colors[1] = newvalue
                        idx += 8
                        idx_cache = idx
                    elif (
                        color_letter == letter_b 
                        and newvalue > game_colors[2].to_int()
                    ):
                        game_colors[2] = newvalue
                        idx += 7
                        idx_cache = idx
        idx += 1

    return result



fn main() raises:
    print("Result:", part1("test_part1.txt"))