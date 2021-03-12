# $ pylint danielaricoa.py
# --------------------------------------------------------------------
# Your code has been rated at 10.00/10 (previous run: 10.00/10, +0.00)
# $ mypy danielaricoa.py
# Success: no issues found in 1 source file

"""Script to solve problem 185 from codeabbey - Simple 3D Scene"""
import math
from typing import List


def get_const(constant: str) -> float:
    """Returns constant value"""
    consts_dict = {
        "num_player_coords": 3.0,
        "min_range": 0.5,
        "max_range": 60.0,
        "screen_distance": 0.5,
        "screen_width": 0.4
    }
    return consts_dict[constant]


def get_points_number() -> int:
    """Get number of points"""
    try:
        return int(input())
    except ValueError:
        raise ValueError("Incorrect data type for points number.")


def get_float_list(string: str) -> List[float]:
    """Converts string to list of floats"""
    splitted = string.split(" ")
    return list(map(float, splitted))


def get_player_coords() -> List[float]:
    """Get player coords and sight angle"""
    player_coords_float = get_float_list(input())

    if len(player_coords_float) != int(get_const("num_player_coords")):
        raise Exception("Error in player coordinates")
    return player_coords_float


def get_points_coords(total_coords: int, index: int,
                      coords: List[List[float]]) -> List[List[float]]:
    """Reads points coordinates"""
    if index == total_coords:
        return coords
    new_coord = get_float_list(input())
    return get_points_coords(total_coords, index + 1, coords + [new_coord])


def translation(player_coords: List[float],
                current_coord: List[float]) -> List[float]:
    """Computes translation for current coord"""
    translated_x = current_coord[0] - player_coords[0]
    translated_y = current_coord[1] - player_coords[1]
    return [translated_x, translated_y]


def translate_coords(player_coords: List[float],
                     points_coords: List[List[float]],
                     translated: List[List[float]],
                     index: int) -> List[List[float]]:
    """Returns translated coords according to player position"""
    if index == len(points_coords):
        return translated

    translated_coord = translation(player_coords, points_coords[index])

    return translate_coords(player_coords, points_coords,
                            translated + [translated_coord], index + 1)


def rotation(player_coords: List[float],
             translated_coord: List[float]) -> List[float]:
    """Computes rotation for current coord"""
    curr_x = translated_coord[0]
    curr_y = translated_coord[1]
    rot_angle = player_coords[2]

    rotated_x = curr_x * math.cos(rot_angle) + curr_y * math.sin(rot_angle)
    rotated_y = - curr_x * math.sin(rot_angle) + curr_y * math.cos(rot_angle)
    return [rotated_x, rotated_y]


def rotate_coords(player_coords: List[float],
                  translated_coords: List[List[float]],
                  rotated: List[List[float]], index: int) -> List[List[float]]:
    """Returns translated coords according to player sight angle"""
    if index == len(translated_coords):
        return rotated

    rotated_coord = rotation(player_coords, translated_coords[index])

    # Discard points with negative x
    if rotated_coord[0] < 0:
        return rotate_coords(player_coords, translated_coords, rotated,
                             index + 1)

    return rotate_coords(player_coords, translated_coords,
                         rotated + [rotated_coord], index + 1)


def eval_distance(current_coord: List[float]) -> bool:
    """Eval if coords are in the vision field, according to distance"""
    distance = math.sqrt(pow(current_coord[0], 2) + pow(current_coord[1], 2))

    if get_const("min_range") < distance < get_const("max_range"):
        return True
    return False


def get_sight_angle() -> float:
    """Computes sight angle according to defined constants"""
    opposite = get_const("screen_width") / 2
    adjacent = get_const("screen_distance")
    return math.atan(opposite / adjacent)


def eval_angle(sight_angle: float, current_coord: List[float]) -> bool:
    """Eval if coords are in the vision field, according to angle"""
    point_angle = math.atan(current_coord[1] / current_coord[0])

    if abs(point_angle) < sight_angle:
        return True
    return False


def eval_sight(sight_angle: float, rotated_coords: List[List[float]],
               answer: List[List[float]],
               index: int) -> List[List[float]]:
    """Eval if coords are in the sight field"""
    if index == len(rotated_coords):
        return answer

    cond_distance = eval_distance(rotated_coords[index])
    cond_angle = eval_angle(sight_angle, rotated_coords[index])

    if cond_distance and cond_angle:
        new_answer = answer + [rotated_coords[index]]
        return eval_sight(sight_angle, rotated_coords, new_answer, index + 1)
    return eval_sight(sight_angle, rotated_coords, answer, index + 1)


def format_answer(answer: List[List[float]], index: int,
                  formatted: List[str]) -> List[str]:
    """Formats answer to be printed"""
    if index == len(answer):
        return formatted

    form_coord = list(map("{:.10f}".format, answer[index]))
    return format_answer(answer, index + 1, formatted + form_coord)


def main() -> None:
    """Performs coordinates translation and rotation and prints output"""
    points_number = get_points_number()
    player_coords = get_player_coords()
    points_coords = get_points_coords(points_number, 0, [])
    translated = translate_coords(player_coords, points_coords, [], 0)
    rotated = rotate_coords(player_coords, translated, [], 0)
    sight_angle = get_sight_angle()
    answer = eval_sight(sight_angle, rotated, [], 0)
    formatted_answer = format_answer(answer, 0, [])
    print(" ".join(formatted_answer))


if __name__ == "__main__":
    main()

# $ cat DATA.lst | python3 danielaricoa.py
# 29.3217947847 -10.9650513269 53.1435657818 -17.4860348848 55.3876240357
# -10.2083839896 32.5162134555 -12.6370828326 31.5658530386 -3.6874004316
# 51.7708229575 -4.5587158612 55.0973878447 20.9350866416 51.9645160370
# 12.5574309888 59.7260962028 -3.7139510463 29.1106035810 -8.9762330156
