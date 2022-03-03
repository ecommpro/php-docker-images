#/bin/sh

TO=$(pwd)/cli-tools ./update-cli-tools.sh
docker run -u$(id -u):$(id -g) -ti --rm -v $(pwd):/work php:7.3-cli-alpine -f /work/build.php
ls build | xargs -P2 -I{} sh -c "docker build -t admibox/php:{} -f build/{}/Dockerfile ."
#docker push -a admibox/php
