package probes::EchoPingChargen;

=head1 301 Moved Permanently

This is a Smokeping probe module. Please use the command 

C<smokeping -man probes::EchoPingChargen>

to view the documentation or the command

C<smokeping -makepod probes::EchoPingChargen>

to generate the POD document.

=cut

use strict;
use base qw(probes::EchoPing);
use Carp;

sub pod_hash {
	return {
		name => <<DOC,
probes::EchoPingChargen - an echoping(1) probe for SmokePing
DOC
		overview => <<DOC,
Measures TCP chargen (port 19) roundtrip times for SmokePing.
DOC
		notes => <<DOC,
The I<udp> variable is not supported.
DOC
		authors => <<'DOC',
Niko Tyni <ntyni@iki.fi>
DOC
		see_also => <<DOC,
probes::EchoPing(3pm)
DOC
	}
}

sub proto_args {
	return ("-c");
}

sub test_usage {
	my $self = shift;
	my $bin = $self->{properties}{binary};
	croak("Your echoping binary doesn't support CHARGEN")
		if `$bin -c 2>&1 127.0.0.1` =~ /(usage|not compiled|invalid option)/i;
	$self->SUPER::test_usage;
	return;
}

sub ProbeDesc($) {
        return "TCP Chargen pings using echoping(1)";
}

sub targetvars {
	my $class = shift;
	my $h = $class->SUPER::targetvars;
	delete $h->{udp};
	return $h;
}

1;
