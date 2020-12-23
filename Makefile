CONTAINER=gameroasters/flatbuffers-unity

docker-build:
	docker build -t ${CONTAINER}:latest --build-arg FLATBUFFER_TAG=v1.12.0 -f Dockerfile .

extract-dll:
	docker run -v $(shell pwd):/dotnet ${CONTAINER}:latest /bin/bash -c "\
	cp /flatbuffers/net/FlatBuffers/bin/Release/FlatBuffers.dll /dotnet && \
	cp /flatbuffers/net/FlatBuffers/bin/Debug/FlatBuffers.dll /dotnet/Flatbuffers.Debug.dll"