FROM mono
ARG FLATBUFFER_TAG=master
LABEL maintainer="extrawurst"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y g++ git cmake make
RUN echo "repo tag: $FLATBUFFER_TAG"
RUN git clone --branch "$FLATBUFFER_TAG" --depth 1 https://github.com/google/flatbuffers.git
# build flatc bin
RUN cd flatbuffers && cmake -G "Unix Makefiles" && make
RUN cp flatbuffers/flatc /usr/local/bin
# build .net DLL
RUN mono --version
RUN msbuild -version
RUN msbuild flatbuffers/net/FlatBuffers/FlatBuffers.csproj
RUN msbuild /p:Configuration=Release flatbuffers/net/FlatBuffers/FlatBuffers.csproj