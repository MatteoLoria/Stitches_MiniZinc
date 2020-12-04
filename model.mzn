int: n;

enum TYPE = {Empty, Right, Down, Implicit};
set of int: indices = 1..n;

array[indices] of int: rowSum;
array[indices] of int: colSum;

array[indices, indices] of int: groups; % il numero di gruppi è sempre n?
% controllo 1/, ecc...

array[indices, indices] of var TYPE: results;
int: rowN;
int: colN;
set of int: rowPair = 1..rowN;
set of int: colPair = 1..colN;
array[rowPair, colPair] of int: pair;

function var int: count_right(int: group1, int: group2) = count(i in indices, j in indices where groups[i,j] == group1 /\ groups[i,j+1] == group2) (results[i,j] == Right);

function var int: count_down(int: group1, int: group2) = count(i in indices, j in indices where groups[i,j] == group1 /\ groups[i+1,j] == group2) (results[i,j] == Down);

constraint forall(i in rowPair, j in colPair) (
  if pair[i,j] == 1 then (count_right(i,j) + count_down(i,j)) == 1 \/ (count_right(j,i) + count_down(j,i)) == 1 else true endif
);

constraint forall(i in indices, j in indices) (
  if results[i,j] == Right then groups[i,j] != groups[i,j+1] else true endif
);

constraint forall(i in indices, j in indices) (
  if results[i,j] == Down then groups[i,j] != groups[i+1,j] else true endif
);

constraint forall(i in indices) (
  sum(j in indices) (results[i,j] != Empty) = rowSum[i]
);

constraint forall(j in indices) (
  sum(i in indices) (results[i,j] != Empty) = colSum[j]
);

constraint forall(i in indices) (results[i,n] != Right);

constraint forall(j in indices) (results[n,j] != Down);

constraint forall(i in indices, j in indices) (
  if results[i,j] == Right then results[i,j+1] = Implicit else true endif
);

constraint forall(i in indices, j in indices) (
  if results[i,j] == Down then results[i+1,j] = Implicit else true endif
);

constraint forall(i in indices, j in indices) (
  if results[i,j] == Implicit then results[i,j-1] = Right xor results[i-1,j] = Down else true endif
);

solve satisfy;

output ["\(results[i,j])," ++ if j == n then "\n" else " " endif | i in indices, j in indices];