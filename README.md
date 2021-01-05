# flatbuffers-unity

convenient cross platform way to use flatbuffers for unity:

1. build flatbuffers .net DLL compatible with Unity
2. easy flatc schema code generation using docker container

based on [dotnet docker image](https://hub.docker.com/_/microsoft-dotnet-sdk/)

Uses [latest master commit](https://github.com/google/flatbuffers) of flatbuffers

# Usage

1. create your schema fbs (`schema.fbs`)
2. use flatc to generate your code (flatc bin in [docker container](https://hub.docker.com/repository/docker/gameroasters/flatbuffers-unity))
3. grab .net DLL for unity from [releases](https://github.com/gameroasters/flatbuffers-unity-docker/releases)
4. done

## example for using flatc

Use:

```sh
docker run -it -v $(pwd):/fb gameroasters/flatbuffers-unity:latest /bin/bash -c "cd /fb && \
	flatc -n --gen-onefile schema.fbs && \
	flatc -r --gen-onefile schema.fbs"
	mv schema_generated.rs schema.rs
```

this will generate a `schema.cs` and `schema.rs` with your `schema.fbs` schema type serialiation in rust and csharp.

## extract .dll for unity

use:

`make extract-dll`

_or_

```sh
docker run -v $(pwd):/dotnet gameroasters/flatbuffers-unity:latest /bin/bash -c "\
	cp /flatbuffers/net/FlatBuffers/bin/Release/FlatBuffers.dll /dotnet && \
	cp /flatbuffers/net/FlatBuffers/bin/Debug/FlatBuffers.dll /dotnet/Flatbuffers.Debug.dll"
```

this extracts the `Flatbuffers.dll`
