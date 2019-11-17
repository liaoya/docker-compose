# README

The client configuration must be the same as server side.

The example of client json file

```json
{
  "remoteaddr": "server:29900",
  "localaddr": "0.0.0.0:4000",
  "key": "password",
  "crypt": "none",
  "mode": "fast2",
  "conn": 3,
  "mtu": 1350,
  "sndwnd": 256,
  "rcvwnd": 512,
  "parityshard": 3,
  "sockbuf": 8388608,
  "smuxver": 1,
  "nocomp": true,
  "acknodelay": false,
  "quiet": true,
  "tcp": false,
  "log": "\/var\/log\/kcptun\/client.general.log"
}
```
