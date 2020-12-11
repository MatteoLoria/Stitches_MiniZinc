from minizinc import Instance, Model, Solver

def main():
    n = 5
    groups = []
    groups.append([1, 2, 2, 1, 3])
    groups.append([1, 1, 1, 1, 3])
    groups.append([4, 4, 3, 3, 3])
    groups.append([4, 4, 4, 4, 4])
    groups.append([5, 5, 4, 4, 5])
    rowN = 5
    colN = 5
    pair = []
    groups.append([0, 1, 1, 1, 0])
    groups.append([1, 0, 0, 0, 0])
    groups.append([0, 0, 0, 1, 0])
    groups.append([0, 0, 1, 0, 1])
    groups.append([0, 0, 0, 1, 0])
    