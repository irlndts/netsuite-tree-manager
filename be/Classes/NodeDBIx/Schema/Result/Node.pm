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

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 pid

  data_type: 'integer'
  is_nullable: 0

=head2 row

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "pid",
  { data_type => "integer", is_nullable => 0 },
  "row",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-07-12 08:14:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0IRXF9VLMlKnQhBvqKKjWw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
