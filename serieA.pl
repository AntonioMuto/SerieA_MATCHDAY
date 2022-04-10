#!/usr/bin/perl

use LWP::Simple;
$ua = LWP::UserAgent->new();
$content = $ua->get('https://www.legaseriea.it/en');
$found = $content->content;
open($fh, ">", "Web.txt");
    print $fh $found;
close $fh;

@arrayCASA;
@arrayTRASFERTA;
@risultati;
$datestring = localtime();
if ($datestring =~ /(((\w+)\s\w+\s\d+\s(\d+))|((\w+)\s\w+\s\d+\s(\d+)))/){
        $giorno = $6;
        $ora = $7;
}
if(($giorno eq "Sun" && $ora <= 23) && ($giorno eq "Sat" && $ora >= 14) ){
   open($fh, "<", "Web.txt");
    while(<$fh>){
        if($_ =~ /class="numero_giornata">\s(\d+)/){
            $giornata = $1;
        }
        if($_ =~ /class="nomesquadra">((\w+)|(\w+\s+\w+))</){
            $teamCasa = $1;
            push @arrayCASA,$1;
        }
        if($_ =~ /<span>-<\/span>/){
             push @risultati,"-"; 
         }
         if($_ =~ /<span>(\d+)<\/span>/){
             push @risultati,$1; 
         }
         if($_ =~ />(Finished)<\/span>/){
            push @tempo,$1;
            push @tempo,$1;
         }
         if($_ =~ /(\d+'\s\dT)\s/){
             push @tempo, $1;
             push @tempo, $1;
         }
    }
close $fh;
}
else{
     open($fh, "<", "Web.txt");
    while(<$fh>){
        if($_ =~ /(\d+ª\sMATCH DAY)\s+<\/div>/){
            $giornata = $1;
        }
        if($_ =~ /class="squadra_left">((\w+)|(\w+\s+\w+))</){
            $teamCasa = $1;
            push @arrayCASA,$1;
        }
        if($_ =~ /class="squadra_right">((\w+)|(\w+\s+\w+))</){
            $teamTrasferta = $1;
            push @arrayTRASFERTA,$1;
        }
        if($_ =~ /class="risultato"></){
             push @risultati,"-"; 
         }
         if($_ =~ /class="risultato">(\d+)</){
             push @risultati,$1; 
         }
    }
  close $fh;
   
}
print "$datestring\n";
print "$giornata\n";

print "\n";
for($i = 0,$y=0; $i < 20,$y<10; $i+=2, ++$y){
    print "@arrayCASA[$y] @risultati[$i] - @risultati[$i+1] @arrayTRASFERTA[$y]";
    print "\n";
}
