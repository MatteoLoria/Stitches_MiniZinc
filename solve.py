import pymzn
import json

solns = pymzn.minizinc('model.mzn', 'input.dzn', all_solutions=True, output_mode='item')

parsed = str(solns).replace('\'', '').replace('[', '').replace(']', '').replace('\\n', '\n')
rows = parsed.split('\n')

results = []
for row in rows:
    tempRow = row.split(', ')
    tempRow[len(tempRow) - 1] = tempRow[len(tempRow) - 1].replace(',', '')
    results.append(tempRow)

jsonFile = open("Stiches/solutions.json", "w")

jsonFile.write(json.dumps(results))

jsonFile.close()