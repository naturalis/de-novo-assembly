#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use FAlite;

# process command line arguments
my $minlength = 10_000; # skip scaffolds shorter than this
my $infile;
my $outfile;
GetOptions(
	'minlength=i' => \$minlength,
	'infile=s'    => \$infile,
	'outfile=s'   => \$outfile,
);

# create the read handle
my $handle;
if ( $infile ) {
	if ( $infile =~ /\.gz$/ ) {
		open $handle, '-|', "gunzip -c $infile" or die $!;
	}
	else {
		open $handle, '<', $infile or die $!;
	}
}
else {
	$handle = \*STDIN;
}

# create the write handle
my $out;
if ( $outfile and $outfile ne '-' ) {
	open $out, '>', $outfile or die $!;
}
else {
	$out = \*STDOUT;
}

# instantiate the reader
my $reader = FAlite->new($handle);

# iterate over records
while( my $seq = $reader->nextEntry ) {
	my $raw = $seq->seq; # defline is ->def		
	if ( length($raw) >= $minlength ) {
		print $out "$seq";		
	}
}
