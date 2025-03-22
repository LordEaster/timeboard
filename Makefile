install:
	chmod +x modules/*.sh setup/boot.sh bin/timeboard

run:
	./bin/timeboard

clean:
	rm -f *.tmp