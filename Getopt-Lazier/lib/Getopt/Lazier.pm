package Getopt::Lazier;

use 5.006;
use strict;
use warnings;
use File::Basename;

=head1 NAME

Getopt::Lazier - Lazy Getopt-like BS

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

`my ($opt, @DARG) = Getopt::Lazier->new(@ARGV);`

=head1 EXAMPLE USAGE

echo '
  use lib "./lib"; use Getopt::Lazier; 
  my ($opt, @DARG) = Getopt::Lazier->new(@ARGV); 
  use Data::Dumper; print Dumper([$opt, \@DARG])
' > lazyscript.pl
perl lazyscript.pl -help a b c d -meow=5345923

$VAR1 = [
          {
            'meow' => '5345923',
            'help' => 1
          },
          [
            'a',
            'b',
            'c',
            'd'
          ]
        ];

=cut 

=head1 EXPORT

eh, maybe later

=head1 SUBROUTINES/METHODS

=head2 new

The laziest way to parse arguments tho

=cut

sub new {    # reimplemented from DocCommon to allow for ENV.
                       # DNM: I <3 this function.
   my $self = shift;
   my @ARGA = @_;
   my $opt  = {};
   my @DARG;
   my $var = uc(basename($0));
   unshift(@ARGA, split(/\s+/, $ENV{$var})) if ($ENV{$var});
   foreach my $ar (@ARGA) {
      if ($ar =~ m/^-(.*?)[=|:](.*)/) {
         ${$opt}{$1} = $2;
      } elsif ($ar =~ m/^-(.*)$/) {
         ${$opt}{$1} = 1;
      } else {
         push @DARG, $ar;
      }
   }
   return ($opt, @DARG);
}

=head1 AUTHOR

Jojess Fournier, C<< <jojessfournier at gmail.com> >>, Dave Maez

=head1 BUGS

Please report any bugs or feature requests to C<bug-getopt-lazier at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Getopt-Lazier>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Getopt::Lazier


You can also look for information at:

L<https://github.com/jojessf/GetOptLazier>

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Getopt-Lazier>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Getopt-Lazier>

=item * Search CPAN

L<https://metacpan.org/release/Getopt-Lazier>

=back


=head1 ACKNOWLEDGEMENTS

Thanks to Dave for the ENV addition.  Also for being awesome. :3 

=cut
=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2024 by Jojess Fournier.

This is free software, licensed under:

  GNU GENERAL PUBLIC LICENSE 3.0


=cut

1; # End of Getopt::Lazier
