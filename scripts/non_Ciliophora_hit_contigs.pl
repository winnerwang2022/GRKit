#!/usr/bin/perl -w
use strict;
open FL, $ARGV[0];
my %hash;
while (<FL>){
	if ($_!~/^\#/){
		chomp;
		my @ar=split(/\t/,$_);
		if($ar[-1]=~/\;/ and $ar[-1]!~/-_unclassified entries/ and $ar[-1]!~/-_other entries/){
			my @tmpx=split(/\#/,$ar[0]);
			$ar[0]=$tmpx[0];
			my $taxon=$ar[6];
			if($taxon=~/p_Ciliophora/){
				$hash{$ar[0]}.="p_Ciliophora\t";
			}else{
				$hash{$ar[0]}.="non-ciliate\t";
			}
		}
	}
}
foreach my $key (sort keys %hash){
	my @ar=split (/\t/,$hash{$key});
	my %freq;
	foreach my $ele (@ar){
		$freq{$ele}++;
	}
	my $firstC;
	my $targetC=0;
	my $c=0;
	foreach my $x (sort {$freq{$b} <=> $freq{$a}} keys %freq){
		if ($x eq "p_Ciliophora"){
			$targetC=$freq{$x};
		}
		$c++;
		if ($c==1){
			$firstC=$freq{$x};
		}
	}
	if($targetC<$firstC){
		print "$key\n";
	}
}
