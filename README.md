

# 🛠️ Mini Compiler with Three-Address Code Generation

A **mini-compiler project** written in **C using Flex and Bison (Lex & Yacc)**. It supports parsing and evaluating arithmetic expressions, assignments, `print` statements, conditional (`if-else`), and looping (`while`) constructs. The compiler generates **three-address code (TAC)** and evaluates expressions at runtime.

---

## 🚀 Features

- Arithmetic expressions  
- Variable assignments  
- `print` statements  
- Conditional logic (`if`, `if-else`)  
- Looping constructs (`while`)  
- Generation of Three-Address Code (TAC)  
- Final evaluation and display of variable values  
- Conflict-free grammar with proper precedence and associativity  

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
a = 5 + 3 * (2 - 1);
b = a + 10;
print b;

if (b > 10) {
    print a;
} else {
    print b;
}

while (a < 20) {
    a = a + 1;
}
```

---

## 📤 Expected Output

```plaintext
b = 18

--- Three Address Code (TAC) ---
t0 = 2 - 1
t1 = 3 * t0
t2 = 5 + t1
a = t2
t3 = a + 10
b = t3
print b
if (b > 10) {...} else {...}
print a
while (a < 20) {...}
t4 = a + 1
a = t4
...

--- Final Variable Values ---
a = 20
b = 18
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
./compiler
```

---

## 📌 Notes

- Input is read from the `input.c` file. Ensure it exists in the same directory.  
- Handles integer arithmetic only.  
- Final variable values are displayed after parsing.  
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
