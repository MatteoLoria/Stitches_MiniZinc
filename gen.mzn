int: n;
constraint assert(n == 5 \/ n == 7 \/ n == 10 \/ n == 15, "n must be equal to 5 or 7 or 10 or 15");

enum TYPE = {Empty, Right, Down, Implicit};
set of int: indices = 1..n;

%numero di buchi esatti per riga e colonna
array[indices] of var int: rowSum;

array[indices] of var int: colSum;

%matrice di gruppi
array[indices, indices] of int: groups;

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

%conta i collegamenti fra due gruppi usando la cucitura "destra"
function var int: count_right(int: group1, int: group2) = count(i in indices, j in indices where groups[i,j] == group1 /\ groups[i,j+1] == group2) (results[i,j] == Right);

%conta i collegamenti fra due gruppi usando la cucitura "sotto"
function var int: count_down(int: group1, int: group2) = count(i in indices, j in indices where groups[i,j] == group1 /\ groups[i+1,j] == group2) (results[i,j] == Down);

%per ogni pair di gruppi collegati, il numero di collegamenti dev'essere 1
constraint forall(i in rowPair, j in colPair) (
  if pair[i,j] == 1 then (count_right(i,j) + count_down(i,j)) == 1 \/ (count_right(j,i) + count_down(j,i)) == 1 else true endif
);

%Se una cella ha valore "Right", la cella di destra deve avere valore "Implicit"
constraint forall(i in indices, j in indices) (
  if results[i,j] == Right then results[i,j+1] = Implicit else true endif
);

%Se una cella ha valore "Down", la cella di destra deve avere valore "Implicit"
constraint forall(i in indices, j in indices) (
  if results[i,j] == Down then results[i+1,j] = Implicit else true endif
);

%Se una cella ha valore "Implicit", la cella di sopra deve avere valore "Down" oppure la cella di sinistra deve avere valore "Right" (or esclusivo)
constraint forall(i in indices, j in indices) (
  if results[i,j] == Implicit then results[i,j-1] = Right xor results[i-1,j] = Down else true endif
);

solve satisfy;

output ["\(results[i,j])," ++ if j == n then "\n" else " " endif | i in indices, j in indices];
