# Build process

The build is run natively on each supported platform before being bundled at the end. The process is roughly:

- `llvm-src`: Get the latest LLVM commit for the branch to build. The commit hash is published as an intermediate artifact and used to ensure all platforms build the same source.
- `llvm-{rid}/build`: For each platform:
  - Get the LLVM source at the specified commit.
  - Invoke `cmake` to build and link a single LLVM native object. For Windows, this final object needs to be linked up outside of LLVM's own build process.
  - Publish the LLVM build as an artifact.
- `llvm-pkg`: Collect platform-specific artifacts and bundle as a nuget package.
