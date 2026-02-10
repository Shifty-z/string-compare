package compare

import "core:strings"
import "core:fmt"
import "core:unicode/utf8"

Result :: struct {
	msg: string,
	success: bool
}

strings :: proc (source, other: string) -> Result {
	if strings.rune_count(source) != strings.rune_count(other) {
		return Result {
			msg = "NOT EQUAL - Number of runes differ",
			success = false
		}
	}

	for source_char, index in source {
		other_char := utf8.rune_at(other, index)

		if other_char != source_char {
			message := fmt.tprintf("NOT EQUAL - Source rune was" +
			" %c and other rune was %c", source_char, other_char)
			return Result {
				msg = message,
				success = false
			}
		}
	}

	return Result {
		msg = "EQUAL",
		success = true
	}
}