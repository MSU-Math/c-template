#!/usr/bin/env bash
ERRORS=0
function countError {
    echo "Проверка завершилась с ошибкой."
    (( ERRORS++ ))
}
trap countError ERR 

echo "# cppcheck"
cppcheck --enable=warning,performance --error-exitcode=2 . && echo "OK" || false

echo "# clang-tidy"
# "--" should be last clang-tidy argument,
# so we concatenate output of "find" with "--"
echo "$(find . -maxdepth 1 -name "*.c*")" "--" | xargs -r clang-tidy --checks=clang-analyzer-*,bugprone-*,performance-*,readability-*,misc-* --warnings-as-errors=*   && echo "OK" || false

echo "# clang-format (форматирование кода)"
find . -maxdepth 1 -name "*.c*" | xargs -r clang-format --style="{BasedOnStyle: llvm, IndentWidth: 4, AlignTrailingComments: false, BreakBeforeBraces: Linux, AllowShortFunctionsOnASingleLine: Inline}" --dry-run -Werror && echo "OK" || false

echo "# Предупреждения GCC"
find . -maxdepth 1 -name "*.c*" | xargs -r g++ -Wall -Wextra -lm -g -O -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all && echo "OK" || false

exit $ERRORS
