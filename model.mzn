int: n;

enum TYPE = {Empty, Right, Down, Implicit};
set of int: indices = 1..n;

array[indices] of int: rowSum;
array[indices] of int: colSum;

array[indices, indices] of int: groups;
% controllo 1/, ecc...

array[indices, indices] of var TYPE: results;

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
  if results[i,j] == Implicit then results[i,j-1] = Right \/ results[i-1,j] = Down else true endif
);

solve satisfy;

output ["\(results[i,j])," ++ if j == n then "\n" else " " endif | i in indices, j in indices];