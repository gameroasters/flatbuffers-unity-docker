CONTAINER=gameroasters/flatbuffers-unity
FLATBUFFER_TAG=master

docker-build:
	docker build -t ${CONTAINER}:latest --build-arg FLATBUFFER_TAG=${FLATBUFFER_TAG} -f Dockerfile .

extract-dll:
	docker run -v $(shell pwd):/dotnet ${CONTAINER}:latest /bin/bash -c "\
	cp /flatbuffers/net/FlatBuffers/bin/Release/FlatBuffers.dll /dotnet && \
	cp /flatbuffers/net/FlatBuffers/bin/Debug/FlatBuffers.dll /dotnet/Flatbuffers.Debug.dll"

