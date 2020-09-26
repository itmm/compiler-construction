# Compiler Construction
* following the Compiler Construction book by Niklaus Wirth
* but using C++ as the language of the compiler
* because no Oberon compiler is available in the Raspberry Pi repository

```
@Def(file: sym.h)
	#pragma once

	#include <cassert>
	#include <iostream>

	namespace symbol {
		enum class Symbol {
			ident, literal, lparen, lbrak,
			lbrace, bar, eql, rparen, rbrak,
			rbrace, period, other
		};

		#if sym_IMPL
			int ch { ' ' };
			char id[32] {};
			Symbol sym { Symbol::other };
			std::istream *in { nullptr };
		#else
			extern char id[32];
			extern Symbol sym;
			extern std::istream *in;
		#endif

		void get()
		#if sym_IMPL
			{
				assert(in);
				while (ch != EOF && ch <= ' ') {
					ch = in->get();
				}
				if (isalpha(ch)) {
					sym = Symbol::ident;
					unsigned i { 0 };
					for (; i < sizeof(id) - 1 && isalpha(ch); ++i) {
						id[i] = ch;
						ch = in->get();
					}
					id[i] = '\0';
				} else switch (ch) {
					case '"': {
						sym = Symbol::literal;
						ch = in->get();
						unsigned i { 0 };
						for (; i < sizeof(id) && ch != '"' && ch > ' '; ++i) {
							id[i] = ch;
							ch = in->get();
						}
						id[i] = '\0';
						ch = in->get();
						break;
					}
					case '=': {
						sym = Symbol::eql;
						ch = in->get();
						break;
					}
					case '(': {
						sym = Symbol::lparen;
						ch = in->get();
						break;
					}
					case ')': {
						sym = Symbol::rparen;
						ch = in->get();
						break;
					}
					case '[': {
						sym = Symbol::lbrak;
						ch = in->get();
						break;
					}
					case ']': {
						sym = Symbol::rbrak;
						ch = in->get();
						break;
					}
					case '{': {
						sym = Symbol::lbrace;
						ch = in->get();
						break;
					}
					case '}': {
						sym = Symbol::rbrace;
						ch = in->get();
						break;
					}
					case '|': {
						sym = Symbol::bar;
						ch = in->get();
						break;
					}
					case '.': {
						sym = Symbol::period;
						ch = in->get();
						break;
					}
					default: {
						sym = Symbol::other; ch = in->get();
						break;
					}
				}
			}
		#else
			;
		#endif
	}
@End(file: sym.h)
```

```
@Def(file: sym.cpp)
	#define sym_IMPL 1
	#include "sym.h"

	int main() {
		symbol::in = &std::cin;
		for (;;) {
			symbol::get();
			if (symbol::sym == symbol::Symbol::other) { break; }
		}
	}
@End(file: sym.cpp)
