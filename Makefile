CONTAINER=gameroasters/flatbuffers-unity
FLATBUFFER_TAG=master

docker-build:
	docker build -t ${CONTAINER}:latest --build-arg FLATBUFFER_TAG=${FLATBUFFER_TAG} -f Dockerfile .

schema-build:
	docker run -it -v $(shell pwd):/fb gameroasters/flatbuffers-unity:latest /bin/bash -c "cd /fb && \
	flatc -n --gen-onefile schema.fbs && \
	flatc -r --gen-onefile schema.fbs"
	mv schema_generated.rs schema.rs

extract-dll:
	docker run -v $(shell pwd):/dotnet ${CONTAINER}:latest /bin/bash -c "\
	cp /flatbuffers/net/FlatBuffers/bin/Release/FlatBuffers.dll /dotnet && \
	cp /flatbuffers/net/FlatBuffers/bin/Debug/FlatBuffers.dll /dotnet/Flatbuffers.Debug.dll"

