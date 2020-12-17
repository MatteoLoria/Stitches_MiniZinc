#!/usr/bin/env python

import sys
import os
import random
import json
from minizinc import Model, Solver, Instance
from numpy import array_split


def gen(instance_data):
    instance = Instance(Solver.lookup('gecode'),
                        Model('gen.mzn'))

    instance['n'] = instance_data['n']
    instance['groups'] = instance_data['groups']
    instance['rowN'] = instance_data['rowN']
    instance['colN'] = instance_data['colN']
    instance['pair'] = instance_data['pairs']

    # results = instance.solve()
    # results = instance.solve(all_solutions=True)
    results = instance.solve(nr_solutions=20)
    res_idx = random.randrange(0, len(results.solution))

    instance_data['rowSum'] = results[res_idx, 'rowSum']
    instance_data['colSum'] = results[res_idx, 'colSum']
    instance_data['results'] = results[res_idx, 'results']
    instance_data['rowSum'] = results[res_idx, 'rowSum']
    instance_data['colSum'] = results[res_idx, 'colSum']
    instance_data['results'] = [ e.tolist() for e in array_split(
        results[res_idx, 'results'],
        instance_data['n']
    )]
    instance_data['results_as_digits'] = [ e.tolist() for e in array_split(
        [ 0 if e == "Empty" else 1 for e in results[res_idx, 'results'] ],
        instance_data['n']
    )]

    return instance_data


basedir = f'./input/{sys.argv[1]}'
inputs = list(filter(lambda e: e.endswith('json'), os.listdir(basedir)))
grid_filename = os.path.join(basedir, random.choice(inputs))

with open(grid_filename, 'r') as handle:
    data = json.load(handle)

res = gen(data)

with open('./finalinput.json', 'w') as handle:
    json.dump(res, handle)

