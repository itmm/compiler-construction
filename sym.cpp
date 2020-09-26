
#line 118 "index.md"

	#define sym_IMPL 1
	#include "sym.h"

	int main() {
		symbol::in = &std::cin;
		for (;;) {
			symbol::get();
			if (symbol::sym == symbol::Symbol::other) { break; }
		}
	}
