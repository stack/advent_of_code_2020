//
//  Data.swift
//  Day 20
//
//  Created by Stephen H. Gerstacker on 2020-12-20.
//

import Foundation

let Example = """
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...
"""

let Input = """
Tile 1579:
.#.##.#..#
#..#......
.#....#...
#.....#...
#..#....##
#.##.....#
#....#....
......###.
..#..#.###
......##.#

Tile 3413:
..##.#....
..##...#..
#....#.#.#
#..#.##...
.###...#.#
#..#..##.#
..#......#
.......#.#
#.....#.##
..#...####

Tile 3559:
#...###..#
##..#.....
.#.#.#....
####....#.
.####....#
..#.#.....
##........
...####.#.
#.......##
...#.#...#

Tile 3947:
#...#..#..
#....##...
.......#..
##.......#
###..##.##
#...#..###
....######
.#....##.#
..........
#....####.

Tile 1063:
#..###..#.
##.#...##.
...##..#.#
#.....####
.#...#....
#...##.#..
#..#....##
...##...#.
#.....#.##
#..#...#..

Tile 3613:
.##.#####.
..#.......
..........
..#.......
.#..#.....
.#.....#..
..###....#
........#.
#....#...#
###.....#.

Tile 3019:
#...#.####
#..#..#..#
..........
......###.
.#.#.....#
#.....#.##
....#.#.#.
##.......#
#..#......
##...###..

Tile 1429:
.#######..
####.....#
.#.##.#...
...##.#..#
....#.###.
#..##.....
...#..####
..#..##..#
#.##......
..##.#..#.

Tile 2543:
....##..#.
#...#.....
#..#..#..#
...#.###..
......####
...#...###
......####
#...#.#..#
..#.....##
...#.##.##

Tile 2447:
.#..#####.
##.#.....#
.....#...#
..#..#..##
#.#...#..#
##.#..#...
#####.#...
##.......#
...#..####
..###.###.

Tile 1471:
.##.###.#.
#...#...##
......##..
.....#....
#....#....
#.....#...
#...#.#...
.......#..
##..#....#
...#..#.##

Tile 1753:
#....#####
.######.#.
.#....##.#
#.........
......#..#
#...##....
#........#
###.......
#..#..#...
..#..#....

Tile 3583:
.##..#####
.........#
##.#...##.
..........
####..##.#
#..#.....#
.#...#...#
...#..###.
....##..#.
..#.##..##

Tile 1447:
###..###..
..#..#.#..
.#....#..#
#..#......
...###...#
#....#....
#....##...
#.####...#
##..###.##
.##...###.

Tile 2143:
##.##.#.#.
....#.....
..........
.......#.#
.#........
#..#....#.
...#......
#..#..#..#
..#.#.#..#
###....#.#

Tile 3433:
##.#...###
......####
.#........
#.##....##
##..#....#
.#...###.#
##.......#
##.....##.
.........#
.#........

Tile 2671:
#...#..###
#...#.#.#.
#...#.#..#
#.#....#.#
#..##.#.##
...#######
#.#..#..#.
#.#.....##
.......#..
.#....##..

Tile 3793:
.#.#.##.#.
##.......#
###..#....
#....#.#..
#..##.#...
#.....##..
.#...##..#
........#.
.##.....#.
###.######

Tile 1109:
....#.###.
.#.......#
#...#....#
..#.#.#.#.
....#.#..#
#.#.......
#.#.....##
.........#
##..#..#..
..####..#.

Tile 2837:
.#.#......
#.........
#.#.......
##.....#..
#...#....#
.....#...#
....###...
###.......
##.....#..
###...#.##

Tile 3529:
.###.#.##.
..#.#....#
.#..##...#
...#...#..
..##...#..
.....#.#.#
....#....#
#...#....#
.#..#..###
..##...##.

Tile 2161:
##..##..#.
.#..#.####
.....#...#
#....#...#
#.#...#...
#.....####
##..##....
....#.#..#
.....#....
.#####.#.#

Tile 2939:
#.........
......#..#
.....##...
....##.#.#
..##.....#
#...#####.
#...###...
#........#
.#......##
...###....

Tile 1409:
.##...####
.....#...#
#......##.
#.#.##..#.
#..#...###
.##......#
#.##...#.#
#.#....#..
.#.....#..
.#..#.....

Tile 2099:
..##.####.
#..##....#
#......#.#
.....#...#
#..#..#...
##.##....#
....#.....
#.....#..#
#...##....
#.##.#..#.

Tile 2081:
###.#.#.#.
.#.##.#..#
###..#####
#.#....#..
...#......
#...##...#
#.#....###
.##...#...
.##...##.#
#.#..##..#

Tile 3943:
..#..##.##
#....#.##.
..##...###
.#.#...#.#
#..####...
#..#...#.#
.##.#..#..
###.....#.
..#.....#.
####.#####

Tile 1867:
.##.#...#.
#..#...##.
#.#.#.....
#...#.....
.........#
..###...#.
...#......
.###..#..#
....#..##.
#...###.#.

Tile 1367:
#.#.#.....
..#.#..#..
........#.
..........
...#.....#
..#.##.##.
..#.#....#
.....#.##.
#......#..
##...####.

Tile 2207:
#.#..#.##.
##..#.#..#
...####...
.#.#...###
.......#..
#...#....#
#.##..#...
....#...##
.........#
.###.#..#.

Tile 2221:
....##.#..
.##....##.
.#..###.##
.#........
#.#.##.#..
....###..#
##.#..##..
..#....#..
##..#..#..
##.#.##..#

Tile 2053:
##.#.#....
#.........
.........#
#..#.#..##
#..#.....#
#....#.#..
#......#..
.....#....
.#.###...#
..##..#.##

Tile 3547:
####.####.
....#.#.##
##.#.#..##
##......#.
#.....#..#
..........
#.#.....##
.#........
.#.#..##..
##.#.##..#

Tile 1307:
#.##.#...#
......#..#
#....#....
#.......##
#.....#...
...##..#.#
.#.#.##...
....##..#.
...#...#.#
..#..#..##

Tile 2683:
#..##..#.#
..#.....##
###.##.#..
##....#...
#.##..#..#
######...#
..##..#..#
####.....#
....####..
#.#.##.#..

Tile 1973:
..##.##..#
#.#.#....#
#..#.#..#.
#...##....
.......#..
.......##.
#...#...##
..##....#.
#...#...##
.#####..##

Tile 2857:
..###.##.#
#..###....
.#.###..#.
#........#
...#.....#
##...#....
.##.###...
#....#...#
.....#...#
#.##...#..

Tile 3079:
##.....###
....#...##
#...##....
.#.#.....#
#.###.##..
###..#.###
#........#
...#......
#........#
#..###.##.

Tile 2281:
###...####
#..#.....#
#.....#...
#.#..#....
##.#...#.#
....##....
...#.#....
##.......#
..#..#....
..##.#.##.

Tile 2677:
####...#..
........##
.....##...
........#.
...#..#..#
...#...#.#
##.#.....#
.##..#.#..
..........
#.#....###

Tile 1151:
....#...##
..#..#..##
##.......#
..#..###..
..#...#..#
...#....#.
#....#....
.#....##.#
##.#.#####
#...##..#.

Tile 1979:
.###.#.#.#
..#..#....
.....#...#
#.#...#.#.
#....##..#
.#..####.#
.........#
##......#.
..#.....##
###.#...##

Tile 3853:
.#.#..#.##
####...#.#
....##...#
..##...#..
.......#.#
..##.#...#
#..#.#...#
.....##.#.
......#...
..#.##..#.

Tile 3359:
.#####.#.#
#..#.#...#
##.#......
...#....#.
....#.#...
..#..###..
#....####.
.......#.#
.#.......#
..#.##.#.#

Tile 3701:
.#.##.##.#
#..#......
#...#..#..
..#.....#.
#...#.....
.##.#....#
#...#..##.
#.##.....#
#...#.....
#.##...#..

Tile 2063:
##.......#
..........
#.#..#....
...##.##..
..#.###..#
#.........
......#..#
.#......#.
.##..####.
......####

Tile 1289:
.####.....
#.....#.#.
#.........
.#....#..#
#..#.....#
.#..#...#.
...#..#..#
#...##...#
...#....##
##.#..###.

Tile 1873:
..#.###.##
##.#.#....
....#..#..
.#.##.....
.#.#......
.####.#.#.
.#......#.
...##..#.#
#...#.#..#
###.##..#.

Tile 1559:
..####.#.#
#.#.#....#
....#.##..
#.##..###.
.#.###....
##....#..#
...#...#..
.#.#......
.#..#.....
...##.####

Tile 2287:
.###..####
#...#...#.
......###.
##.#......
#.#....#.#
.....#.#.#
..##.#...#
.#..#.##.#
##...#.###
.######...

Tile 2423:
.#.##...#.
#......#..
.#.#.##...
###.#...##
#.##..#...
.###.....#
##.###.#.#
#........#
##...#..##
.##.#..##.

Tile 2269:
..#.....##
...##.#..#
#.........
....##....
##.......#
......#..#
.......#.#
##...#....
...#....#.
...####.#.

Tile 1223:
...##...#.
#..###....
#..#..#..#
.#........
....##....
#.#......#
#........#
.....#....
.###....#.
##....####

Tile 1723:
.##..#..##
#..#.....#
.#....#..#
.##.......
...#..#..#
##........
##....##..
........##
....##....
..#.#....#

Tile 2371:
#...#.##..
#......##.
.#.#...#..
##...#..##
#...#....#
#..#.#.#..
#.#.....##
.....#..##
.##..###..
#..##..#..

Tile 2339:
#..###..##
..#..#.#..
##.......#
#..#......
#....##...
#..#...##.
.....#.#.#
#.#....#.#
#.#..#..#.
.#.##....#

Tile 1693:
.##.......
..#.###.#.
##.......#
##....#..#
#...#.....
#.#......#
..#.....#.
#.#......#
#.......#.
.#....###.

Tile 1811:
.#..#..#..
.#....##..
#.#...#..#
#....#...#
#...#.....
#.##..##..
#..##.....
#.....#...
#..#.....#
####.##...

Tile 2137:
###..#..#.
....#.#.##
.#..#..#.#
##....#.##
#....##...
##...#.##.
#.##..#...
.#........
##......#.
##..##..#.

Tile 2693:
.###..#.##
....#.#.#.
#.#.......
#...#.#...
#....#....
....##...#
.....#..#.
#.##...##.
#.#....###
#..#..##.#

Tile 3833:
##.##.....
#....#...#
#.......#.
#.......#.
##.##.....
..##.....#
....#...##
##.......#
..#.......
#####.####

Tile 2351:
#..###.##.
.........#
..#...#..#
..#.###...
#.#.#.#...
..##.....#
#.##..#..#
#.....#.#.
##.#....##
#.####.##.

Tile 3607:
.#.###....
.#..#....#
###...##.#
...#....##
#...###..#
#..###....
#..#....#.
...#.#....
##.#..#...
##.###..#.

Tile 1097:
.#.##.#.##
.#..##.#..
.......#.#
..........
#.#.#...##
##.....#.#
#...##...#
.#.......#
.##.##..#.
...##....#

Tile 3217:
..#.###...
.#..#....#
#..#....##
#...#...##
#.###...#.
.####..#.#
..#...#...
..#.#....#
..##.#...#
#.......#.

Tile 3083:
###..##.##
#........#
#.#.#.#..#
.....##...
..#..###..
#.###...##
........##
##...#....
##...#....
#..##.#..#

Tile 2273:
..###..#..
##.##.#.#.
......##..
......##..
.##..#..##
#..#....#.
.#.##.#..#
...##..###
#.....#..#
##..####.#

Tile 2957:
.####.#...
#.........
...#......
...#..#..#
..##......
#........#
..#.#.#..#
.##.......
...#.....#
####.#.##.

Tile 2521:
###.####.#
###..#..#.
#.........
...#...###
#..#...#..
.....##...
.....##.##
##........
#....#.#.#
..#..##.#.

Tile 1039:
##.#..####
#.......#.
.#.......#
#......##.
#.#...#...
..#..#.#..
###....###
.#..#....#
#....###.#
.####.####

Tile 2003:
....####..
.#...##..#
...#.....#
....#.....
#.......#.
..#....#..
....#.#.##
.#..##...#
...#...#.#
..###.####

Tile 3307:
##..#.#.#.
##.#......
....#.#...
.##.....#.
.........#
....##..##
..##......
##........
.....###..
##.#....##

Tile 2557:
...##.#...
.#....#.##
##....##..
#......#..
#......#..
......#..#
#.#...#...
#...#.#...
..........
.#.#.#.#.#

Tile 2731:
..#.###.#.
#.#..#....
#..#..#..#
#####..#..
#.....####
.....#.#..
........##
#.#.##...#
...#......
...#.#.#.#

Tile 2011:
#...####.#
#.....#.#.
###..#.#..
#...#...##
#..##.##..
....#.....
#.....#.#.
.#.....#..
##...#...#
..###..##.

Tile 2801:
#..#.##...
###.......
###.#.....
......#...
...##.....
#.........
..##..###.
##.#....##
#...##..#.
##.##..#.#

Tile 2909:
#..##...#.
........#.
....#.#...
.#....#.#.
#.......##
##..##....
....#..#..
..#....#..
#.#.....##
#.###.##..

Tile 2549:
#.#.#....#
#.###.....
.....#....
###.#.....
........#.
#.........
#..#...#.#
.#...#....
#......#..
######.##.

Tile 1567:
...#.##.#.
#.#.#..#..
##.#..###.
#.......##
##........
#..#.#..#.
#.........
....#..#..
..........
.#.#####..

Tile 1231:
.##.#.#..#
.#......##
..#.#.....
###..##.##
...#....##
...#.#..##
.....#..#.
#..#......
#....####.
####..#..#

Tile 2089:
####...#.#
#.....#.##
.........#
.#...#....
...#..#.##
##.#......
##....#...
..#..#..##
...##..#..
#.##......

Tile 2719:
.##..#.#.#
#........#
.......#..
##...#....
..#.#.....
#..##....#
#.#..##.#.
#.........
#.........
..####.##.

Tile 1789:
..#.#.##.#
.....#.###
.....#...#
..#..#..##
..........
..##....##
##.#...#.#
.##...##.#
..####..#.
.#.##.##.#

Tile 1009:
.##.###.#.
#....##..#
###...#...
...#.#..##
#...#.#..#
#.##.....#
..#.#...#.
..#.......
.#.#......
.##.#.#.#.

Tile 2477:
...###.#..
..##......
#.#..#..#.
.#.#..####
#......#.#
.##..#....
##..##....
...#..#.#.
..........
.##..##.##

Tile 1013:
#.#..#####
#.#....#..
..#.#..###
#....##..#
.#.#.....#
#...#.##..
.#....##.#
..#......#
#.#..#.#..
#.##.#####

Tile 1451:
#..##..###
..###...##
.....#.#.#
#...#.....
...#.#....
#.#.......
.#..##...#
##..######
#.#....#.#
#.#..##.#.

Tile 1667:
..#.##..#.
#.#...#.##
.#.###...#
..##......
.........#
####..##.#
.........#
.....#..##
##...##..#
##..#.#.#.

Tile 1511:
.#..#..###
#..#..##.#
....#...##
....##...#
...##.....
#...#..##.
#.##..#.#.
..........
...#....##
###.#.##.#

Tile 2917:
.#####....
....#...#.
#..#.....#
#.....#.#.
...#.#.##.
#.##.....#
......####
#....#..#.
..#####..#
#.##.##.##

Tile 3877:
#....####.
#.........
#.....#.#.
.#.....#..
....#..#.#
##.##.##..
..#..#..#.
#..##....#
...#..#.#.
.....#..##

Tile 3319:
#.#.######
#.......#.
.#......##
.........#
#.....#.##
#..####...
#..###....
#.##...#.#
#.........
...##.#.##

Tile 1087:
##..####.#
#.##.....#
.........#
...#......
....#..##.
..#..#..##
.###..##.#
#..#.....#
.....##..#
#.#.######

Tile 1279:
.#####.#..
....#.....
.........#
##........
..#...#...
.#........
..###.##..
.....#....
#.##.#.#.#
#..#...#..

Tile 3257:
.......#..
...#..##..
#.#..#..##
.#..#.##.#
#.........
..#.......
#..######.
..#......#
....#.....
...###..#.

Tile 2579:
....####.#
....#..#.#
.#.......#
....#..#..
#.##...###
.#.#...###
##........
#.#.####..
#.#..##..#
####..##..

Tile 1091:
.#..###.##
.#....#..#
#.........
#...#..#.#
#.#......#
#.#.#.#..#
#.#.##..#.
.#....#.#.
#....#...#
##.##..###

Tile 1423:
.#....#...
.....#..#.
#.#....#.#
#.#####..#
#....#...#
.####.....
.#.###....
....#....#
#..#.##...
...#...#..

Tile 2531:
####.#..##
.#...##..#
........#.
.#....#.#.
...####..#
##........
#....#..##
...#....#.
#......#..
.........#

Tile 3767:
.#...#.##.
..#.#.#..#
#.#..#..#.
.......#.#
...###...#
#...###.##
#..#..#...
#....###..
#...####.#
.###.#####

Tile 2833:
#......##.
##.....##.
........#.
#...#..#..
#....#....
##......##
....####.#
......#.##
##....#...
#..#.##...

Tile 1291:
###.#..#..
#..##.#.#.
........##
#.......#.
...#......
......#.##
..........
.#.....###
#...##....
..##.####.

Tile 2399:
##.....#..
#..####..#
##...#..##
#....#.#.#
.##.#..#..
#.#......#
#.#..#....
#...#.#.##
..#....#..
...##..#..

Tile 1997:
.##.#..##.
..........
....#.....
......#.##
.#.##..#..
.........#
###..#..##
#..#.##...
..###.....
....####..

Tile 3119:
..##..#..#
#.#..#....
#.........
#...##.##.
##.....#.#
...#..#...
#..##....#
...#......
##..#.#...
.#..#.####

Tile 2417:
.#.#.##...
#..#.##...
....#...#.
.........#
......#.#.
.#...#....
###.....#.
....#.....
#..#.#....
####..#.##

Tile 3643:
.....##...
.#.#.###..
#..#......
##....#...
#.........
##.#....##
##.#......
#.#..####.
#.....#...
#..###...#

Tile 3491:
..##.##.#.
##.....#.#
#...##...#
####....#.
...#..#...
#........#
#...##...#
##.......#
###.....#.
#....#.##.

Tile 1103:
#.#...##.#
#.........
...#..##..
.....#...#
.........#
#...##..##
#..#..#..#
....#..#.#
#.....##..
####.#..#.

Tile 3001:
.#######..
#.##....##
..##......
##..#.....
....##.#..
#...#.....
#.....##..
#..#...###
......#...
.##.#..#..

Tile 3301:
..##.#..##
....#.....
#.#.....#.
...#......
#....#...#
#.#.....#.
#....#..#.
....##.###
........##
###.##..##

Tile 2411:
...###.###
.#.##.#...
.....#..#.
.....#....
.........#
.....#....
....#...#.
.....#....
##..#.....
##..#.#...

Tile 3769:
.#.#.#....
..#....##.
#....#...#
.#.......#
...#......
.#.....#.#
#.###..#.#
##.##....#
..#.##.#.#
.##.#.##.#

Tile 2791:
..##.#.#.#
#..#..#..#
...#......
.#.......#
....#.....
#.........
#.......#.
#....##..#
#.#.....#.
.###....#.

Tile 1381:
..##.##...
##........
#.........
..##.#.#.#
....#...##
##......#.
....#..#..
.....##.#.
#.....#.##
##..#....#

Tile 1181:
....#...#.
###..#..#.
##.......#
#....#.#.#
....#...#.
.##.#.#.#.
.#..#....#
.#.##.....
...##....#
...##..#.#

Tile 1999:
#..##.##.#
###..#....
#.........
.##.......
.#..##.#..
.###..#.#.
.......#.#
#.......#.
..#...##.#
..##..#...

Tile 2749:
.......#.#
.#....#..#
...#.#....
#.........
....###..#
.#...##...
....#.##..
#.#...#.#.
..#..##.##
#.###..#.#

Tile 2393:
#.###.....
#..#.###.#
.......#.#
#....###.#
#.....#...
...##..#.#
##........
##....#...
...#..###.
#...##..#.

Tile 2707:
..#..#####
###..##.#.
...#....##
..........
#..#..#...
#.#....##.
#.........
#.#......#
#.#.#....#
.#.##.....

Tile 1901:
##.#####..
#.#....#..
#..#.#.#..
....#.#.##
....#....#
..###.....
#.##.#.#.#
#.#...#..#
##.#..#..#
.##..#.#..

Tile 3821:
###..#####
#.....###.
#........#
#....#....
.#..#.#...
.#.#..#...
#.#..#...#
##........
.##.#.....
.....###..

Tile 2239:
#..#.##.#.
#...#.....
#.........
..#.#.#...
#....#.#..
.....#...#
#.#.#...#.
##...##...
..##.#.#.#
#.##.###..

Tile 2659:
#.####.###
#.......#.
...#.....#
....#..##.
#......#.#
.##...#...
##........
#...##.#.#
#.#...#..#
#..#####..

Tile 3517:
.#..###.#.
.##.#.#.#.
###.#...##
....#...#.
#.#.##....
..##..#...
.......#..
...#.....#
#.#......#
..####..##

Tile 2111:
######.##.
#....#...#
.....##..#
......#.##
.#.###...#
.##..#..##
##.......#
.#.....#.#
...#..#..#
.#.###.###

Tile 3109:
.#.#.##...
#...##...#
#......#.#
..#......#
#.#...#.##
#...#....#
......#..#
##.......#
#.#..##.##
#.#......#

Tile 3691:
...#...##.
##....##.#
..#...##..
...##..###
.#.#......
#.###..#..
...#......
#...#...##
.#........
.##.##....

Tile 1889:
#...#.#...
#.......#.
..##..#..#
#.....#..#
..#.#...##
#....#....
#...#.....
#...#..##.
#..#....##
#.....#.#.

Tile 1051:
.......##.
#.........
#..#..#..#
#......#.#
.....##...
..#...##..
#........#
#......#..
..#..#....
.....#.#.#

Tile 2633:
...#####..
#....#....
#.....#...
...##.....
..#.#.....
#.....##..
#..###..##
#..#.#...#
#..##.#.##
##...##.##

Tile 1949:
##.#..#...
.#....#...
#........#
#.#.#....#
#.......#.
#..###.##.
.#......##
.#........
...##.....
..#...#...

Tile 3169:
##..#.##..
..........
#......#..
#.........
..........
#...###..#
..#.####.#
#......#..
##..#....#
..##...##.

Tile 2027:
#..##...##
........#.
#.#......#
##.....#.#
##...##..#
..#.##.#..
#...#.#..#
#.#.......
..#.#..##.
...####.##

Tile 2851:
.####...##
#.#....#.#
..##......
...##.....
#...#...##
..##....#.
#....##.#.
.#..#...#.
#.##...#..
.##....#..

Tile 1213:
#.##.#####
#....#..##
#........#
#.##......
..#.#...##
..........
....#.#...
#....##...
#....#..#.
####.#.#.#

Tile 1847:
#..#..##.#
.........#
.........#
...#....#.
...#...#.#
#...#..#..
#...#..##.
###..#.#.#
#....####.
####.###.#

Tile 2843:
.###...##.
#..#....##
....#.#...
#.......##
#.#....#.#
......#..#
.....###..
##....#...
.......#..
##..##.#.#

Tile 1163:
..#.#..###
....##....
..#.#...#.
#.#.....##
.#........
##..#.....
#...#....#
...#..#..#
##...#.#.#
#.....#..#

Tile 3617:
.#.#.#.###
.....#.#.#
.........#
#........#
#.#.##.#.#
####.#..#.
.##...####
.......#..
###..#...#
..####.#.#

Tile 2963:
#.......#.
.....#...#
.##......#
#.#....###
..##...#..
#.###..#.#
....#....#
..#.#...##
#..###....
#..#..#.#.

Tile 1709:
#...#.##..
.#....####
.....#.#.#
#........#
#..###....
#......###
###.....#.
....#..#..
.##.#....#
.#.#...#..

Tile 1583:
.#.##.#.#.
#.....#..#
.....##...
##....#..#
##.#.....#
.#.......#
#.##.#..##
##..#..###
...#....#.
..#.###.#.

Tile 3881:
####.#.#.#
.....#.#.#
#......#.#
...#......
.#.....#..
....#.#.##
..........
##.....#..
#...##...#
..#.###..#

"""
