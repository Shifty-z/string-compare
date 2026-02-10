package main

import "compare"
import "core:flags"
import "core:os/os2"
import "core:fmt"

ProgramArgs :: struct {
	source: string   `flags:"source" usage:"String that 'other' should match."`,
	other: string `flags:"other" usage:"String that should match 'source'."`,
}

EXIT_CODE_NO_ERROR :: 0
EXIT_CODE_ERROR :: 1

main :: proc () {
	args := ProgramArgs{ }

	parse_err := flags.parse(&args, os2.args[1:])
	if nil != parse_err {
		flags.print_errors(ProgramArgs, parse_err,
		"String Compare - Determine whether strings are equal.",
		.Odin)

		os2.exit(EXIT_CODE_ERROR)
	}

	result := compare.strings(args.source, args.other)
	fmt.println(result.msg)
}