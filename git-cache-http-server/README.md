# Setup Git HTTPS mirror

If the build need download the public git repository e.g. GitHub, the build will be very slow.
We can use <https://github.com/jonasmalacofilho/git-cache-http-server> to cache the remote git repository.

## How to use it

`git config --global url."http://gitcache:8080/".insteadOf https://`
