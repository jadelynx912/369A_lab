def main():
    file = open("datamem.txt", "r")
    output = open("output.txt", "w")
    for line in file:
        line = line.split(" <= 32'h")[1].strip(";\n")
        outline = "0" * (8 - len(line)) + line
        output.write(outline + "\n")
    file.close()
    output.close()


main()
