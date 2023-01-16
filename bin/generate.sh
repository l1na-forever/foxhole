#!/bin/bash
set -eo pipefail

_help() {
	cat << EOF
USAGE: $(basename $0) <input path to parameters.conf> <output path to rathole_server.conf> <output path to rathole_client.conf>

Generates rathole configuration files from the given parameters.conf:

  REMOTE_IP=<remote address of the server host>
  SERVER_TUNNEL_BIND_PORT=<port through which the client will connect to the server host>
  CLIENT_LOCAL_PORT=<client port being forwarded, usually a service's port>
  SERVER_REMOTE_PORT=<port on the server through which the forwarded service will be available>
EOF
}

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
	_help
	exit 1
fi

params_path=$1
server_conf_path=$2
client_conf_path=$3

. $params_path
if [[ -z "$REMOTE_IP" || 
      -z "$SERVER_TUNNEL_BIND_PORT" || 
      -z "$CLIENT_LOCAL_PORT" || 
      -z "$SERVER_REMOTE_PORT" ]] 
then
  _help
  exit 1
fi

keypair=$(rathole --genkey | grep -v ":")

LOCAL_PRIVATE_KEY=$(echo "$keypair" | head -n 1)
REMOTE_PUBLIC_KEY=$(echo "$keypair" | tail -n 1)
TOKEN=$(echo $RANDOM)

cat > $server_conf_path <<EOF
[server]
bind_addr = "0.0.0.0:$SERVER_TUNNEL_BIND_PORT"
default_token = "$TOKEN"

[server.services.svc]
bind_addr = "0.0.0.0:$SERVER_REMOTE_PORT"

[server.transport]
type = "noise"

[server.transport.noise]
local_private_key = "$LOCAL_PRIVATE_KEY"
EOF

cat > $client_conf_path <<EOF
[client]
remote_addr = "$REMOTE_IP:$SERVER_TUNNEL_BIND_PORT"
default_token = "$TOKEN"

[client.services.svc]
local_addr = "127.0.0.1:$CLIENT_LOCAL_PORT"

[client.transport]
type = "noise"

[client.transport.noise]
remote_public_key = "$REMOTE_PUBLIC_KEY"
EOF

