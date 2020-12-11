int: n;
constraint assert(n == 5 \/ n == 7 \/ n == 10 \/ n == 15, "n must be equal to 5 or 7 or 10 or 15");

enum TYPE = {Empty, Right, Down, Implicit};
set of int: indices = 1..n;

%numero di buchi esatti per riga e colonna
array[indices] of var int: rowSum;
%constraint assert(forall(i in indices)(rowSum[i] >= 0 /\ rowSum[i] <= n), "Each row clue mustn't be negative and mustn't be greater than n");

array[indices] of var int: colSum;
%constraint assert(forall(i in indices)(colSum[i] >= 0 /\ colSum[i] <= n), "Each column clue mustn't be negative and mustn't be greater than n");


%matrice di gruppi
array[indices, indices] of int: groups;
% controllo 1/, ecc...

%matrice di variabili decisionali
array[indices, indices] of var TYPE: results;


%dimensioni della matrice di adiacenza dei gruppi
int: rowN;
constraint assert(rowN > 0, "Number of groups must be greater than 0");

int: colN;
constraint assert(colN > 0, "Number of groups must be greater than 0");

set of int: rowPair = 1..rowN;
set of int: colPair = 1..colN;

%matrice di adiacenza
array[rowPair, colPair] of int: pair;
constraint assert(forall(i in rowPair, j in colPair)(pair[i,j] >= 0 /\ pair[i,j] <= 1), "Elements of the adjacency matrix must be 0 or 1");

%l'ultima colonna non può avere un valore "Right"
constraint forall(i in indices) (results[i,n] != Right);

%l'ultima riga non può avere un valore "Down"
constraint forall(j in indices) (results[n,j] != Down);

%il numero di buchi per ogni riga deve corrispondere esattamente al valore in input per quella riga
constraint forall(i in indices) (
  sum(j in indices) (results[i,j] != Empty) = rowSum[i]
);

%il numero di buchi per ogni colonna deve corrispondere esattamente al valore in input per quella colonna
constraint forall(j in indices) (
  sum(i in indices) (results[i,j] != Empty) = colSum[j]
);

%Non è possibile che ad una cella venga assegnato Right se alla sua destra il gruppo non cambia
constraint forall(i in indices, j in indices) (
  if results[i,j] == Right then groups[i,j] != groups[i,j+1] else true endif
);

%Non è possibile che ad una cella venga assegnato Down se sotto di essa il gruppo non cambia
constraint forall(i in indices, j in indices) (
  if results[i,j] == Down then groups[i,j] != groups[i+1,j] else true endif
);

function var int: count_right(int: group1, int: group2) = count(i in indices, j in indices where groups[i,j] == group1 /\ groups[i,j+1] == group2) (results[i,j] == Right);

function var int: count_down(int: group1, int: group2) = count(i in indices, j in indices where groups[i,j] == group1 /\ groups[i+1,j] == group2) (results[i,j] == Down);

constraint forall(i in rowPair, j in colPair) (
  if pair[i,j] == 1 then (count_right(i,j) + count_down(i,j)) == 1 \/ (count_right(j,i) + count_down(j,i)) == 1 else true endif
);

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
