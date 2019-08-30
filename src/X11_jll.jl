module X11_jll
using Pkg, Pkg.BinaryPlatforms, Pkg.Artifacts, Libdl

# Load Artifacts.toml file
artifacts_toml = joinpath(@__DIR__, "Artifacts.toml")

# Extract all platforms
artifacts = Pkg.Artifacts.load_artifacts_toml(artifacts_toml, UUID("546b0b6d-9ca3-5ba2-8705-1bc1841d8479"))
platforms = [Pkg.Artifacts.unpack_platform(e, "X11", artifacts_toml) for e in artifacts["X11"]]

# Filter platforms based on what wrappers we've generated on-disk
platforms = filter(p -> isfile(joinpath(@__DIR__, "wrappers", triplet(p))), platforms)

# From the available options, choose the best platform
best_platform = select_platform(Dict(p => triplet(p) for p in platforms))

# Load the appropriate wrapper
include(joinpath(@__DIR__, "wrappers", "$(best_platform).jl"))

end  # module X11_jll
