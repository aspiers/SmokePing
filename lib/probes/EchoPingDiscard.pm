package probes::EchoPingDiscard;

=head1 301 Moved Permanently

This is a Smokeping probe module. Please use the command 

C<smokeping -man probes::EchoPingDiscard>

to view the documentation or the command

C<smokeping -makepod probes::EchoPingDiscard>

to generate the POD document.

=cut

sub pod_hash {
	return {
		name => <<DOC,
probes::EchoPingDiscard - an echoping(1) probe for SmokePing
DOC
		overview => <<DOC,
Measures TCP or UDP discard (port 9) roundtrip times for SmokePing.
DOC
		authors => <<'DOC',
Niko Tyni <ntyni@iki.fi>
DOC
		see_also => <<DOC,
probes::EchoPing(3pm)
DOC
	}
}

use strict;
use base qw(probes::EchoPing);
use Carp;

sub proto_args {
	my $self = shift;
	my $target = shift;
	my @args = $self->udp_arg;
	return ("-d", @args);
}

sub test_usage {
	my $self = shift;
	my $bin = $self->{properties}{binary};
	croak("Your echoping binary doesn't support DISCARD")
		if `$bin -d 127.0.0.1 2>&1` =~ /(not compiled|invalid option|usage)/i;
	$self->SUPER::test_usage;
	return;
}

sub ProbeDesc($) {
	return "TCP or UDP Discard pings using echoping(1)";
}


1;
