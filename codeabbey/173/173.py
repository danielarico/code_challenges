"""Script to solve problem 173 from codeabbey - chords of music"""
from typing import List, Dict, Tuple

TOTAL_NOTES = 12


def get_testcases_number() -> int:
    """Get number of test cases to be read"""
    try:
        return int(input())
    except ValueError:
        raise ValueError("Incorrect data type for testcases number.")


def get_testcases(number: int, index: int, testcases: List[str]) -> List[str]:
    """Reads testcases"""
    if index == number:
        return testcases
    return get_testcases(number, index + 1, testcases + [input()])


def testcases_to_list(testcases: List[str], i: int,
                      tc_list: List[List[str]]) -> List[List[str]]:
    """Return testcases as a list"""
    if i == len(testcases):
        return tc_list
    new_testcases = tc_list + [testcases[i].split(" ")]
    return testcases_to_list(testcases, i + 1, new_testcases)


def normalize(note: str) -> int:
    """Represents note in the first octave"""
    octave = int(int(note) / TOTAL_NOTES)
    normalized_note = int(int(note) - (octave * TOTAL_NOTES))
    return normalized_note


def compute_step(root: int, step: int) -> int:
    """Computes note at a given distance from the root"""
    if root + step > TOTAL_NOTES - 1:
        return step - (TOTAL_NOTES - root)
    return root + step


def find_steps(root: int) -> List[int]:
    """Find third and fifth notes for a given root"""
    three_steps = compute_step(root, 3)
    four_steps = compute_step(root, 4)
    seven_steps = compute_step(root, 7)
    return [three_steps, four_steps, seven_steps]


def check_steps_existence(chord_notes: List[int], root: int,
                          norm: List[int]) -> Tuple[bool, int, str]:
    """Check if computed third and fifth for root exists in the testcase"""
    # Check if fifth is in the array
    if chord_notes[2] in norm:
        # Check if third is in the array
        if chord_notes[0] in norm:
            return (True, root, "minor")
        if chord_notes[1] in norm:
            return (True, root, "major")
        return (False, root, "other")
    return (False, root, "other")


def find_is_chord(normalized: List[int], i: int) -> Tuple[bool, int, str]:
    """Find if given normalized notes are a chord"""
    if i == len(normalized):
        return (False, 0, "other")

    possible_root = normalized[i]
    # chord_notes receives [three_steps, four_steps, seven_steps]
    chord_notes = find_steps(possible_root)
    is_chord = check_steps_existence(chord_notes, possible_root, normalized)

    if is_chord[0]:
        return is_chord
    return find_is_chord(normalized, i + 1)


def eval_chords(notes_dict: Dict[int, str], tc_list: List[List[str]],
                i: int, answer: List[str]) -> List[str]:
    """Eval testcases to find chords"""
    if i == len(tc_list):
        return answer

    normalized = list(map(normalize, tc_list[i]))
    is_chord_answer = find_is_chord(normalized, 0)
    is_chord = is_chord_answer[0]
    root = is_chord_answer[1]
    chord_type = is_chord_answer[2]

    if is_chord:
        new_answer = answer + [notes_dict[root] + "-" + chord_type]
        return eval_chords(notes_dict, tc_list, i + 1, new_answer)
    return eval_chords(notes_dict, tc_list, i + 1, answer + ["other"])


def main() -> None:
    """Prints chords founded from input"""
    notes_dict = {
        0: "C",
        1: "C#",
        2: "D",
        3: "D#",
        4: "E",
        5: "F",
        6: "F#",
        7: "G",
        8: "G#",
        9: "A",
        10: "A#",
        11: "B"
    }

    testcases_number = get_testcases_number()
    input_data = get_testcases(testcases_number, 0, [])
    input_data_list = testcases_to_list(input_data, 0, [])
    evaluated = eval_chords(notes_dict, input_data_list, 0, [])
    print(" ".join(evaluated))


if __name__ == "__main__":
    main()

# $ cat DATA.lst | python3 danielaricoa.py
# G-minor C#-minor E-major F#-minor G-minor C-major G-major G#-minor B-minor
# G-major E-major E-minor F#-major C#-minor other C-major G#-minor F#-minor
# A#-major D-minor other F-minor D#-major F-major A#-major G#-minor F-major
# E-major B-minor G-minor C-major C#-minor F-major A-major D#-minor
