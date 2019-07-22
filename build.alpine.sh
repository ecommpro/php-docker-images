#/bin/sh
docker run -ti --rm -v $(pwd):/work php:7.3-cli-alpine -f /work/build.alpine.php
ls build.alpine | xargs -P4 -I{} sh -c "docker build -t ecommpro/php:{}-alpine -f build.alpine/{}/Dockerfile . && docker push ecommpro/php:{}-alpine"
