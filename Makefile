all: configs

configs: 
	mkdir -p build && \
	bin/generate.sh foxhole.conf build/rathole_server.toml build/rathole_client.toml
	
clean:
	rm -f build/rathole_server.toml
	rm -f build/rathole_client.toml

.PHONY: clean

