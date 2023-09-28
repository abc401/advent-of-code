const std = @import("std");

const Location = struct { x: i32, y: i32 };

const HashSet = std.AutoHashMap(Location, void);

fn part1() !void {
    var location = Location{ .x = 0, .y = 0 };
    var input_file = try std.fs.cwd().openFile("input.txt", .{});
    defer input_file.close();
    var reader = input_file.reader();
    var buffer: [1024]u8 = undefined;
    var visited = HashSet.init(std.heap.page_allocator);
    while (try reader.readAll(&buffer) > 0) {
        for (buffer) |char| {
            try visited.put(location, {});
            switch (char) {
                '^' => location.y += 1,
                'v' => location.y -= 1,
                '>' => location.x += 1,
                '<' => location.x -= 1,
                else => unreachable,
            }
        }
        // robo_location.y += delta.y;
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("count: {}", .{visited.count()});
}

fn part2() !void {
    var santa_location = Location{ .x = 0, .y = 0 };
    var robo_location = Location{ .x = 0, .y = 0 };
    var index: u32 = 0;

    var input_file = try std.fs.cwd().openFile("input.txt", .{});
    defer input_file.close();
    var reader = input_file.reader();
    var buffer: [1024]u8 = undefined;

    var visited = HashSet.init(std.heap.page_allocator);
    defer visited.deinit();

    var delta = Location{ .x = 0, .y = 0 };
    while (try reader.readAll(&buffer) > 0) {
        for (buffer) |char| {
            switch (char) {
                '^' => delta = Location{ .x = 0, .y = 1 },
                'v' => delta = Location{ .x = 0, .y = -1 },
                '>' => delta = Location{ .x = 1, .y = 0 },
                '<' => delta = Location{ .x = -1, .y = 0 },
                else => unreachable,
            }
            if (index % 2 == 0) {
                santa_location.x += delta.x;
                santa_location.y += delta.y;
                try visited.put(santa_location, {});
            } else {
                robo_location.x += delta.x;
                robo_location.y += delta.y;
                try visited.put(robo_location, {});
            }
            index += 1;
        }
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("count: {}", .{visited.count()});
}

pub fn main() !void {
    // try part1();
    // try part2();
}
