#!/usr/bin/perl 

use warnings;
use strict;

my $file = $ARGV[0] || 'genotypes.txt';
my $counter = 1;
open(FILE,'<', $file) || die "Can't find file $file \n";
open(OUT, '>', 'out.txt') || die "Can't open out file out.txt \n";

while (<FILE>) {
    chomp;

    my($marker, $accession1, $accession2) = split('\t', $_);

    #remove first 3 characters from marker string
    #$marker =~ s/^.{3}//;
    my $rounded_accession1 = $accession1;
    my $rounded_accession2 = $accession2;
    if ($counter > 1) {
	$rounded_accession1 = &round_to_nearest_integer($accession1);
	$rounded_accession2 = &round_to_nearest_integer($accession2); 
    }
    print OUT join ("\t", $marker, $accession1, $accession2, $marker, $rounded_accession1, $rounded_accession2) ."\n";

    $counter++;
    #if ($counter == 3) { last;}
}
    
sub round_to_nearest_integer {
    my $raw_value = $_[0];
    if ($raw_value eq 'NA') { 
	return 'NA';
    }
    if ($raw_value <= 0.5) {
	return 0;
    }
    elsif ( $raw_value >= 1.5) {
	return 2;
    }
    else {
	return 1;
    }
}
