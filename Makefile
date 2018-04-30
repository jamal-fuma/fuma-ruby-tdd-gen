# $^ = all deps
# $< = first dep
# $@ = target

.PHONY= results.tmp clean

results.log: results.tmp
	mv $< $@
	cat results.log

results.tmp:
	find tests/suites -maxdepth 1 -name '*.rb' | xargs ruby $<  > $@

clean:
	rm -f results.log results.tmp
