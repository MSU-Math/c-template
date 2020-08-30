with import <nixpkgs> {};

mkShell {
    buildInputs = [ gcc gdb 
        cppcheck clangAnalyzer clang-tools
    ];
}
