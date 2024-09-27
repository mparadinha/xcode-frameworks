const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "xcode-frameworks",
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
        .target = target,
        .optimize = optimize,
    });
    addPaths(b, &lib.root_module); // just for testing
    lib.linkLibC();
    lib.installHeadersDirectory(b.path("include"), ".", .{});
    b.installArtifact(lib);
}

pub fn addPaths(b: *std.Build, mod: *std.Build.Module) void {
    mod.addSystemFrameworkPath(b.path("Frameworks"));
    mod.addSystemIncludePath(b.path("include"));
    mod.addLibraryPath(b.path("lib"));
}
