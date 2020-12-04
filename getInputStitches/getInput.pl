#!/usr/bin/perl

$fileInput = shift || die "Nessun file di input fornito";

die "Troppi parametri dati in input" if (scalar @ARGV);

$sumsString;
$groupsInput;

@input = qx{cat $fileInput};

for(@input){
    
    chomp;

    if($_ =~ m/(.+);(.+)/){
        $sumsString = $1;
        $groupsInput = $2;
    }

}

@sums = split('_', $sumsString);

$size = scalar @sums;
$n = $size/2;
$i = 1;
#print($i);

@rowSums;
@colSums;

for(@sums){

    if($i <= $n){
        push(@colSums, $_);
    }
    else{
        push(@rowSums, $_);
    }

    $i++;

}


@groups = split(',', $groupsInput);

open($data, ">", "../input.dzn") || die "Impossibile aprire il file $! \n";

print $data "n = $n;\n";

$i = $n;
print $data "colSum = [";
for(@colSums){
    
    print $data "$_";
    $i--;
    if ($i > 0){
        print $data ",";
    }

}
print $data "];\n";

$i = $n;
print $data "rowSum = [";
for(@rowSums){
    
    print $data "$_";
    $i--;
    if ($i > 0){
        print $data ",";
    }

}
print $data "];\n";

print $data "groups =\n";
print $data "[";
$i = $n;

for(@groups){

    if($i == $n){
        print $data "| ";
    }

    print $data "$_";

    $i--;
    if ($i > 0){
        print $data ",";
    }
    else{
        print $data "\n";
        $i = $n;
    }

}

print $data "|];";

close $data;