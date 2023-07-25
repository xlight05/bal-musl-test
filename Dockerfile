# Auto Generated Dockerfile
FROM ghcr.io/graalvm/native-image:muslib-ol8-java11-22.3.2 as build

WORKDIR /app/build

COPY bal_musl_play.jar .

# RUN sh build-native.sh bal_musl_play.jar bal_musl_play '-H:+StaticExecutableWithDynamicLibC'

RUN native-image -jar bal_musl_play.jar --no-fallback -H:Name=bal_musl_play --static --libc=musl

FROM alpine

WORKDIR /home/ballerina

COPY --from=build /app/build/bal_musl_play .

CMD ["./bal_musl_play"]

