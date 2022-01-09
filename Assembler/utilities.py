Regsiters = {
    "r0": "000",
    "r1": "001",
    "r2": "010",
    "r3": "011",
    "r4": "100",
    "r5": "101",
    "r6": "110",
    "r7": "111"
}

opcodes = {
    "nop": "0000110",
    "hlt": "0000010",

    "setc": "0000000",
    "not": "0000100",
    "inc": "0001000",
    "mov": "0001100",
    "add": "0010000",
    "and": "0010100",
    "sub": "0011000",
    "iadd": "0011100",

    "in": "0000001",
    "out": "0000101",
    "ldd": "0001001",
    "std": "0001101",
    "push": "0010001",
    "pop": "0010101",
    "ldm": "0011001",

    "jz": "0000011",
    "jc": "0000111",
    "jn": "0001011",
    "jmp": "0001111",
    "call": "0010011",
    "ret": "0010111",
    "int": "0011011",
    "rti": "0011111"
}

operands = {
    "nop":  {"names": [], "pos": ""},
    "hlt":  {"names": [], "pos": ""},
    "setc": {"names": [], "pos": ""},

    "not":  {"names": ['dst', "src1"],
             "pos": {"dst": 1, "src1": 1}},

    "inc":  {"names": ['dst', "src1"],
             "pos": {"dst": 1, "src1": 1}},

    "mov":  {"names": ['dst', "src1"],
             "pos": {"dst": 2, "src1": 1}},

    "add":  {"names": ['dst', "src1", "src2"],
             "pos": {"dst": 1, "src1": 2, "src2": 3}},

    "and":  {"names": ['dst', "src1", "src2"],
             "pos": {"dst": 1, "src1": 2, "src2": 3}},

    "sub":  {"names": ['dst', "src1", "src2"],
             "pos": {"dst": 1, "src1": 2, "src2": 3}},

    "iadd": {"names": ['dst', "src1", "offset"],
             "pos": {"dst": 1, "src1": 2, "offset": 3}},

    "out":   {"names": ['src1'],
              "pos": {"src1": 1}},

    "in":  {"names": ['dst'],
            "pos": {"dst": 1}},

    "ldd":  {"names": ['src1', 'dst', 'offset'],
             "pos": {"src1": 3, "dst": 1, "offset": 2}},

    "std":  {"names": ['src1', "src2", "offset"],
             "pos": {"src1": 3, "src2": 1, "offset": 2}},

    "push": {"names": ['src2'],
             "pos": {"src2": 1}},

    "pop":  {"names": ['dst'],
             "pos": {"dst": 1}},

    "ldm":  {"names": ["dst", "offset"],
             "pos": {"dst": 1, "offset": 2}},

    "jz":   {"names": ['src1'],
             "pos": {"src1": 1}},

    "jc":   {"names": ['src1'],
             "pos": {"src1": 1}},

    "jn":   {"names": ['src1'],
             "pos": {"src1": 1}},

    "jmp":  {"names": ['src1'],
             "pos": {"src1": 1}},

    "call": {"names": ['src1'],
             "pos": {"src1": 1}},

    "ret": {"names": [], "pos": ""},
    "int": {"names": ["index"], "pos": {"index": 1}},
    "rti": {"names": [], "pos": ""}
}
