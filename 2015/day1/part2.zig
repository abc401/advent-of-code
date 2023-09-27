const std = @import("std");

pub fn main() !void {
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var istream = buf_reader.reader();
    var buffer: [100]u8 = undefined;
    var floor: i32 = 0;
    var index: usize = 0;
    outer: while (try istream.readAtLeast(&buffer, buffer.len) > 0) {
        std.debug.print("buffer contents: {s}\n", .{buffer});
        for (buffer) |char| {
            if (char == '(') {
                floor += 1;
            } else if (char == ')') {
                floor -= 1;
            }
            index += 1;
            if (floor == -1) {
                var stdout = std.io.getStdOut().writer();
                try stdout.print("index: {}, floor: {}", .{ index, floor });
                break :outer;
            }
        }
    }

    // while (try istream.streamUntilDelimiter(writer: anytype, delimiter: u8))
}
