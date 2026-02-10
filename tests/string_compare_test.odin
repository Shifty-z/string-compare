package tests

import "core:testing"
import "../compare"

assert_true :: proc (t: ^testing.T, actual: $a_type, loc := #caller_location) {
	testing.expect(t, true == actual, "Expected result to be true")
}

assert_false :: proc (t: ^testing.T, actual: $a_type, loc := #caller_location) {
	testing.expect(t, false == actual, "Expected result to be false")
}

@(test)
single_word_lowercase_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("odin", "odin")
	assert_true(t, r.success)
}

@(test)
single_word_capital_letter_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("Odin", "Odin")
	assert_true(t, r.success)
}


@(test)
single_word_random_capital_letter_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("odIn", "odIn")
	assert_true(t, r.success)
}

@(test)
single_word_mismatch_should_not_equal :: proc (t: ^testing.T) {
	r := compare.strings("oDin", "odin")
	assert_false(t, r.success)
}

@(test)
phrase_lowercase_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("some sentence, right?", "some sentence, right?")
	assert_true(t, r.success)
}

@(test)
phrase_first_letter_capitalized_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("Some sentence, right?", "Some sentence, right?")
	assert_true(t, r.success)
}

@(test)
phrase_random_letter_capitalized_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("some sEntence, right?", "some sEntence, right?")
	assert_true(t, r.success)
}

@(test)
phrase_mismatch_should_not_equal :: proc (t: ^testing.T) {
	r := compare.strings("some sentence, right?", "some sEntence, right?")
	assert_false(t, r.success)
}

@(test)
sentence_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("^Use 123 the included test shell script via `sh test.sh` to run tests. Alternatively,use `odin test tests/` if you prefer.",
	"^Use 123 the included test shell script via `sh test.sh` to run tests. Alternatively,use `odin test tests/` if you prefer.")
	assert_true(t, r.success)
}

@(test)
csv_string_with_numbers_no_spaces_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("123,456,789,111,2,33,12.3",
	"123,456,789,111,2,33,12.3")
	assert_true(t, r.success)
}

@(test)
csv_string_with_numbers_with_spaces_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("123, 456, 789, 111, 2, 33, 12.3",
	"123, 456, 789, 111, 2, 33, 12.3")
	assert_true(t, r.success)
}

@(test)
csv_string_with_numbers_with_spaces_mismatch_should_not_equal :: proc (t: ^testing.T) {
	r := compare.strings("123, 456, 789,111,2, 33, 12.3",
	"123, 456, 789, 111, 2, 33, 12.3")
	assert_false(t, r.success)
}

@(test)
uuid_like_all_lowercase_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("5bfccf3f-9c90-4ac1-a773-53df503ab96c",
	"5bfccf3f-9c90-4ac1-a773-53df503ab96c")
	assert_true(t, r.success)
}

@(test)
uuid_like_all_capitalized_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("5BFCCF3F-9C90-4AC1-A773-53DF503AB96C",
	"5BFCCF3F-9C90-4AC1-A773-53DF503AB96C")
	assert_true(t, r.success)
}

@(test)
emoji_should_equal :: proc (t: ^testing.T) {
	r := compare.strings("😂", "😂")
	assert_true(t, r.success)
}

@(test)
emoji_different_should_not_equal :: proc (t: ^testing.T) {
	r := compare.strings("😂", "😜")
	assert_false(t, r.success)
}