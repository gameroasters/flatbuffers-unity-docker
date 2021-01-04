FROM mcr.microsoft.com/dotnet/sdk:5.0
ARG FLATBUFFER_TAG=v1.12.0
LABEL maintainer="extrawurst"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y g++ git cmake make
RUN echo "repo tag: $FLATBUFFER_TAG"
RUN git clone --branch master --depth 1 https://github.com/google/flatbuffers.git
# build flatc bin
RUN cd flatbuffers && cmake -G "Unix Makefiles" && make
RUN cp flatbuffers/flatc /usr/local/bin
# build .net DLL
RUN dotnet --version
RUN mkdir -p flatbuffers/Release/
RUN mkdir -p flatbuffers/Debug/
RUN dotnet build -m:1 -o ./flatbuffers/Debug/ "flatbuffers/net/FlatBuffers/FlatBuffers.csproj"
RUN dotnet build -m:1 -c Release -o ./flatbuffers/Release/ "flatbuffers/net/FlatBuffers/FlatBuffers.csproj"