# Шаблон простой программы на языке C

Содержит следующие проверки:

- `build` — собирает программу
    с проверками на утечку памяти и на выход за границы массива.
    Можно запустить на своём компьютере (локально) командой `.github/build.sh`

- `lint` — выполняет стандартные проверки:
    - компиляция со всеми предупреждениями
    - проверка кода анализаторами `clang-tidy` и `cppcheck`
    - проверка форматирования кода анализатором `clang-format` (нужна версия 10)
    Если перечисленные средства установлены,
    проверку можно запустить локально командой `.github/build.sh`.

Файлы в каталоге `.github` студентам редактировать запрещено.

## Требования к форматированию кода

Не все требования к оформлению можно проверить автоматически.
Даже к программе, которая проходит проверку `clang-format` преподаватель может оставить замечания по оформлению, стилю идентификаторов и удобству чтения.
Общий стиль оформления близок к K&R.

Размер отступов — 4 пробела. Внутри каждого блока (внутри фигурных скобок) добавляется новый уровень отступа.

Фигурные скобки, открывающие блоки, пишутся на той же строке, что и операторы `if`, `for`, `while`, `do`, `switch`, через пробел.
На отдельной строке фигурные скобки пишутся в определении функций и пространств имён в C++.
Перед скобками после операторов `if`, `for`, `while`, `switch` ставится пробел.
Перед скобками с аргументами в вызове функции пробел НЕ ставится.

Если `clang-format` есть только более старых версий,
можно автоматически переформатировать код следующей командой.
Внимание: ключ `-i` переписывает файлы. Это может «испортить» форматирование, если в программе есть синтаксические ошибки.
Поэтому на всякий случай, сделайте коммит перед запуском `clang-format`.

```
clang-format --style="{BasedOnStyle: llvm, IndentWidth: 4, AlignTrailingComments: false, BreakBeforeBraces: Linux, AllowShortFunctionsOnASingleLine: Inline}" -i ./main.c
```

Пример правильно отформатированного кода:

```c
#include <stdio.h>

void output(char character, char *line);

void output(char character, char *line)
{
    printf("Argument: %s\nFirst char: %c", line, character);
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        printf("Not enough arguments: %d!\n", argc);
        return 1;
    }

    output(argv[1], argv[1][0]);
    return 0;
}
```