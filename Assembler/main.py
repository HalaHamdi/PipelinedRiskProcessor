from utilities import *
import os
import string

binary = ["0" * 16] * 10000

with open('./TestCases/Branch.asm') as f:
    index = 0
    for i, line in enumerate(f):
        line = line.strip()

        instruction = ' '.join(line.split()).lower().split(',')
        instruction = ' '.join(instruction).split('(')
        instruction = ' '.join(instruction).split(')')
        instruction = ' '.join(instruction).split()

        isAdd = False

        # .org instructions
        if (len(line) != 0 and line[0] == '.'):
            index = int(instruction[1], 16)

        # for address
        if(len(line) != 0 and len(instruction) == 1 and all(c in string.hexdigits for c in instruction[0])):
            isAdd = True
            add = f"{int(instruction[0], 16):032b}"
            binary[index] = add[16:]
            index += 1
            binary[index] = add[:16]

        # other instructions
        if (len(line) != 0 and instruction[0].isalpha() and not(isAdd)):
            src1 = "000"
            src2 = "000"
            dst = "000"
            opcode = opcodes[instruction[0]]

            if "src1" in operands[instruction[0]]['names']:
                loc = operands[instruction[0]]['pos']['src1']
                src1 = Regsiters[instruction[loc]]

            if "src2" in operands[instruction[0]]['names']:
                loc = operands[instruction[0]]['pos']['src2']
                src2 = Regsiters[instruction[loc]]

            if "dst" in operands[instruction[0]]['names']:
                loc = operands[instruction[0]]['pos']['dst']
                dst = Regsiters[instruction[loc]]

            if "index" in operands[instruction[0]]['names']:
                loc = operands[instruction[0]]['pos']['index']
                src1 = f"{int(instruction[loc], 16):03b}"

            binary[index] = f"{opcode}{dst}{src2}{src1}"
            index += 1

            if "offset" in operands[instruction[0]]['names']:
                loc = operands[instruction[0]]['pos']['offset']
                offset = f"{int(instruction[loc], 16):016b}"
                binary[index] = offset
                index += 1

with open("output.mem", "w") as f:
    for instruction in binary:
        f.write(instruction)
        f.write('\n')
