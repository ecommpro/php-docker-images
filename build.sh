#/bin/sh

TO=$(pwd)/cli-tools ./update-cli-tools.sh
docker run -u$(id -u):$(id -g) -ti --rm -v $(pwd):/work php:7.3-cli-alpine -f /work/build.php
ls build | xargs -P4 -I{} sh -c "docker build -t ecommpro/php:{} -f build/{}/Dockerfile ."
docker push -a ecommpro/php
