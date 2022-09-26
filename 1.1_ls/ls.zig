const std = @import("std");
const builtin = @import("builtin");

pub fn main() !u8 {
    var args = std.process.args();
    var allocator = std.heap.page_allocator;

    _ = try args.next(allocator).?;
    const dir = try args.next(allocator).?;

    var dirent = try std.fs.cwd().openDir(dir, .{ .iterate = true });
    var iter = dirent.iterate();
    const print = std.debug.print;

    while (try iter.next()) |entry| {
        print("{s}\n", .{entry.name});
    }
    return 0;
}
