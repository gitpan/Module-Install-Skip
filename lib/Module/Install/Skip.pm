package Module::Install::Skip;
use strict;

use vars qw( @ISA $VERSION );
use Module::Install::Base;
@ISA = qw(Module::Install::Base);

$VERSION = 0.01;

=head1 NAME

Module::Install::Skip - Module::Install extension that allow skip files with regexp.

=head1 SYNOPSIS

  Makefile.PL
	use inc::Module::Install;
	...
	# will skip *.in files from installation
	skip('\.in$');
	...

=head1 METHODS

=head2 skip

Takes one argument - regexp. Returns nothing.
Files that match regexp wouldn't be installed. Subsequent requests
override previous so use complex regular expression instead.

=cut

sub skip
{
	my ($self, $regexp) = @_;

	my $callback = <<END;

package MY;

sub libscan
{
	my \$keeper = shift->SUPER::libscan(\@_);

	return '' if( \$keeper =~ /$regexp/ );
	return \$keeper;
};
1;
END

	eval "$callback";
	die $@ if( $@ );

	return;
}

=head1 NOTES

=head2 preamble

This extension doesn't cover drop-ins into Makefile that was done directly,
for example with ExtUtils::MakeMaker->preamble call.

For example: Module::Install::RTx use preamble call for all dirs except
libs, you can filter lib files but not bin/sbin.

=head2 libscan

M::I::Skip uses libscan overriding. I didn't test with other
Module::Install extensions which uses libscan too because
I don't know no such extensions on CPAN yet.

=head1 AUTHOR

	Ruslan U. Zakirov
	cubic@wildgate.miee.ru

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with perl distribution.

=head1 SEE ALSO

Module::Install.

=cut

1;
__END__

