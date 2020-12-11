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
    pair.append([0, 1, 1, 1, 0])
    pair.append([1, 0, 0, 0, 0])
    pair.append([0, 0, 0, 1, 0])
    pair.append([0, 0, 1, 0, 1])
    pair.append([0, 0, 0, 1, 0])

    model = Model("model.mzn")
    gecode = Solver.lookup("gecode")
    instance = Instance(gecode, model)
    instance['n'] = n
    instance['groups'] = groups
    instance['rowN'] = rowN
    instance['colN'] = colN
    instance['pair'] = pair
    result = instance.solve()
    if not result:
        print("NO SOL")
    else:
        solutionCol = result['colSum']
        solutionRow = result['rowSum']
        solutionRes = result['results']

        print(solutionCol)
        print(solutionRow)
        print(solutionRes)

if __name__ == '__main__':
    main()

