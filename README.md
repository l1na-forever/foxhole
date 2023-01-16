Foxhole 🦊🕳️
==
Configures my [`rathole`](https://github.com/rapiz1/rathole) client and server.

Usage
--
To generate the `rathole` configuration file, first, set up the parameters
in `foxhole.conf`:

```
REMOTE_IP=<remote address of the server host>
SERVER_TUNNEL_BIND_PORT=<port through which the client will connect to the server host>
CLIENT_LOCAL_PORT=<client port being forwarded, usually a service's port>
SERVER_REMOTE_PORT=<port on the server through which the forwarded service will be available>
```

Then, simply invoke `make`. Rathole can then be invoked on the server
via `rathole rathole_server.toml`, and on the client via `rathole
rathole_client.toml`.

License
--
Copyright © 2023 Lina

Permission to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of this software (the "Software"), subject to the following conditions:

The persons making use of this "Software" must furnish the nearest cat with gentle pats, provided this is acceptable to both parties (the "person" and the "cat"). Otherwise, water a plant 🪴.

