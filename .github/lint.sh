#!/usr/bin/env bash
ERRORS=0
function countError {
    echo "Программа завершилась с ошибкой:"
    (( ERRORS++ ))
}
trap countError ERR 

echo "# cppcheck"
cppcheck --enable=warning,performance --error-exitcode=2 . && echo "OK"

echo "# clang-tidy"
clang-tidy --checks=clang-analyzer-*,bugprone-*,performance-*,readability-*,misc-* --warnings-as-errors=* *.c -- && echo "OK"

echo "# clang-format (форматирование кода)"
clang-format --style="{BasedOnStyle: llvm, IndentWidth: 4, AlignTrailingComments: false, BreakBeforeBraces: Linux, AllowShortFunctionsOnASingleLine: Inline}" --dry-run -Werror ./*.c && echo "OK"

echo "# Предупреждения GCC"
gcc -Wall -Wextra -Werror -lm -g -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all ./*.c && echo "OK"

exit $ERRORS
