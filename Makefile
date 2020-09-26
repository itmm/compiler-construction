MARKDOWNs := $(wildcard *.md)

CXXFLAGS += -g -Wall -std=c++17
LDLIBS += -lboost_filesystem
LDLIBS += -lboost_system
LDLIBS += -lboost_iostreams
APP = sym

.PHONY: clean

hx-run: $(MARKDOWNs)
	@echo 'HX'
	@which hx >/dev/null && hx || true
	@date >$@
	@make --no-print-directory $(APP)

clean:
	@echo 'RM'
	@rm -f *.h *.cpp $(APP) hx-run

%: %.cpp
	@echo "C++ $^"
	@$(LINK.cpp) $^ $(LOADLIBES) $(LDLIBS) -o $@
