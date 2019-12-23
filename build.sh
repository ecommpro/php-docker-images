#/bin/sh
docker run -ti --rm -v $(pwd):/work php:7.3-cli-alpine -f /work/build.php
ls build | xargs -P4 -I{} sh -c "docker build -t ecommpro/php:{} -t ecommpro/php:{}-debian -f build/{}/Dockerfile ."
# docker push ecommpro/php
