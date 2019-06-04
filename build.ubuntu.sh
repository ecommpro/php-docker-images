#/bin/sh
docker run -ti --rm -v $(pwd):/work php:7.3-cli-alpine -f /work/build.ubuntu.php
#ls build | xargs -P4 -I{} sh -c "docker build -t ecommpro/php:{}-ubuntu -f build.ubuntu/{}/Dockerfile . && docker push ecommpro/php:{}-ubuntu"
ls build | xargs -P4 -I{} sh -c "docker build -t ecommpro/php:{}-ubuntu -f build.ubuntu/{}/Dockerfile ."
