use utf8;
package Classes::NodeDBIx::Schema::Result::Node;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Classes::NodeDBIx::Schema::Result::Node

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nodes>

=cut

__PACKAGE__->table("nodes");

=head1 ACCESSORS

=head2 uid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 pid

  data_type: 'integer'
  is_nullable: 1

=head2 cid

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "uid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "pid",
  { data_type => "integer", is_nullable => 1 },
  "cid",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</uid>

=back

=cut

__PACKAGE__->set_primary_key("uid");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-10 15:34:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0eeUbDuezDCjvDZSX7RizQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
