#/bin/sh
docker run -ti --rm -v $(pwd):/work php:7.3-cli-alpine -f /work/build.debian.php
ls build.debian | xargs -P4 -I{} sh -c "docker build -t ecommpro/php:{}-debian -f build.debian/{}/Dockerfile . && docker push ecommpro/php:{}-debian"

