

# 🛠️ Mini C Compiler For Three-Address Code Generation

A **mini C compiler project** written in **C using Flex and Bison (Lex & Yacc)**. It supports parsing and evaluating arithmetic expressions, assignments, `print` statements, conditional (`if-else`), and looping (`while`) constructs. The compiler generates **three-address code (TAC)** and evaluates expressions at runtime.

---

## 🚀 Features

- Arithmetic expressions  
- Variable assignments  
- `print` statements  
- Conditional logic (`if`, `if-else`)  
- Looping constructs (`while`)  
- Generation of Three-Address Code (TAC)

---

## 🧠 Concepts Demonstrated

- **Lexical analysis** using Flex  
- **Syntax analysis and parsing** using Bison (Yacc)  
- **Three-address code generation**  
- **Basic symbol table** for variable storage  
- **Conflict-free grammar** with precedence and associativity  

---

## 📂 File Structure

```plaintext
.
├── lexer.l        # Lex file: token definitions
├── yacc.y         # Yacc file: grammar rules and TAC generation
├── input.c        # Sample input file with source code
└── README.md      # Project documentation
```

---

## 🧪 Sample Input (`input.c`)

```c
a = 10;
b = 20;
if (a < b) {
    print a;
} else {
    print b;
}
for (i = 0; i < 3; i = i + 1) {
    print i;
}

```

---

## 📤 Expected Output

```plaintext
Error: syntax error

--- Three Address Code ---
a = 10
b = 20
t0 = a < b
print a
print b
ifFalse t0 goto L0
goto L1
L0:
L1:
i = 0
t1 = i < 3
t2 = i + 1
```

---

## ⚙️ How to Compile & Run

Ensure `flex` and `bison` are installed.

### 🧱 Compilation Steps

```bash
yacc -d yacc.y
lex lexer.l   
gcc y.tab.c lex.yy.c -o compiler -ll
```

### ▶️ Run the Compiler

```bash
./compiler < input.c
```

---

## 📌 Notes

- Input is read from the `input.c` file. Ensure it exists in the same directory.  
- Handles integer arithmetic only.    
- Control structures are converted to TAC and evaluated at a basic level.  

---

## ✨ Future Enhancements

- Support for floating-point numbers  
- Functions and return statements  
- Logical operators (`&&`, `||`, `!`)  
- Translation of TAC to assembly or intermediate VM code  
- Full AST implementation with an interpreter backend  

---

## 🧑‍💻 Authors

Developed as part of a **Compiler Design Lab Final Project** using Flex, Bison, and C programming.

---

## 📃 License

This project is licensed under the **MIT License**. Feel free to use, learn, and modify.

---
```
