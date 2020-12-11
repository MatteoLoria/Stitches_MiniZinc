import sys

instance_name = sys.argv[1]
print(instance_name)
f_write = open("../" + instance_name + ".dzn", "w")
f_json = open("../" + instance_name + ".json", "w")
f_read = open(instance_name, "r")

f_json.write("{")

line = f_read.readline().split(";")
cols_rows = line[0].split("_")
groups = line[1].split(",")
n = int(len(cols_rows) / 2)

cColsTemp = []
cRowsTemp = []
for num in cols_rows:
    if len(cColsTemp) >= n:
        cRowsTemp.append(num)
    else:
        cColsTemp.append(num)

cCols = "colSum=["
cCols_json = "\"colSum\":["
for i in range(len(cColsTemp)):
    if i == len(cColsTemp) - 1:
        cCols = cCols + cColsTemp[i] + "];"
        cCols_json = cCols_json + cColsTemp[i] + "],"
    else:
        cCols = cCols + cColsTemp[i] + ","
        cCols_json = cCols_json + cColsTemp[i] + ","

cRows = "rowSum=["
cRows_json = "\"rowSum\":["
for i in range(len(cRowsTemp)):
    if i == len(cRowsTemp) - 1:
        cRows = cRows + cRowsTemp[i] + "];"
        cRows_json = cRows_json + cRowsTemp[i] + "],"
    else:
        cRows = cRows + cRowsTemp[i] + ","
        cRows_json = cRows_json + cRowsTemp[i] + ","

matrix_groups = []
temp = []
for i in range(len(groups)):
    if i > 0 and i % n == 0:
        matrix_groups.append(temp)
        temp = []
    temp.append(int(groups[i]))
matrix_groups.append(temp)

matrix = "groups=[|"
matrix_json = "\"groups\": [\n["
for i in range(n):
    for j in range(n):
        matrix = matrix + str(matrix_groups[i][j]) + ","
        matrix_json = matrix_json + str(matrix_groups[i][j]) + ","
    matrix = matrix[:len(matrix) - 1] + "|"
    if i != n - 1:
        matrix_json = matrix_json[:len(matrix_json) - 1] + "],\n["
    else:
        matrix_json = matrix_json[:len(matrix_json) - 1]
matrix = matrix + "];"
matrix_json = matrix_json + "]\n]"

rowN = max(groups)
colN = rowN

adjacents = []
for i in range(int(rowN)):
    adjacents_temp = []
    for j in range(int(colN)):
        adjacents_temp.append(0)
    adjacents.append(adjacents_temp)

for i in range(n):
    for j in range(n):
        if j + 1 < n and matrix_groups[i][j] != matrix_groups[i][j + 1]:
            adjacents[matrix_groups[i][j] - 1][matrix_groups[i][j + 1] - 1] = 1
        if i + 1 < n and matrix_groups[i][j] != matrix_groups[i + 1][j]:
            adjacents[matrix_groups[i][j] - 1][matrix_groups[i + 1][j] - 1] = 1

pair = "pair=[|"
for i in range(int(n)):
    for j in range(int(n)):
        pair = pair + str(adjacents[i][j]) + ","
    pair = pair[:len(pair) - 1] + "|"
pair = pair + "];"

f_write.write("n = {};\n".format(n))
f_json.write("\"n\": {},\n".format(n))
f_write.write(cCols + "\n")
f_json.write(cCols_json + "\n")
f_write.write(cRows + "\n")
f_json.write(cRows_json + "\n")
f_write.write(matrix + "\n")
f_json.write(matrix_json + "\n")
f_json.write("}")
f_write.write("rowN = {};\n".format(rowN))
f_write.write("colN = {};\n".format(colN))
f_write.write(pair + "\n")

f_write.close()
f_read.close()
f_json.close()
