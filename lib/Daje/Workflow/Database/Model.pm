package Daje::Workflow::Database::Model;
use Mojo::Base -base, -signatures;

use Daje::Workflow::Database::Model::Workflow;
use Daje::Workflow::Database::Model::Context;

# NAME
# ====
#
# Daje::Workflow::Database::Connector
#
#
# REQUIRES
# ========
#
# Daje::Workflow::Database::Model::Context>
#
# Daje::Workflow::Database::Model::Workflow>
#
# Mojo::Base>
#
#
# METHODS
# =======
#
#  load($self)
#
#  load_context($self)
#
#  load_workflow($self)
#
#  save_context($self)
#
#  save_workflow($self)
#
#  start($self)
#
#  stop($self,
#
# LICENSE
# =======
#
# Copyright (C) janeskil1525.
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# AUTHOR
# ======
#
# janeskil1525 E<lt>janeskil1525@gmail.comE<gt>
#

our $VERSION = "0.01";

has 'db';
has 'workflow_pkey';
has 'workflow';
has 'context';

sub load($self) {
    my $data->{workflow} = $self->load_workflow();
    $self->workflow_pkey($data->{workflow}->{workflow_pkey});
    $data->{context} = $self->load_context();
    return $data;
}

sub load_workflow($self) {
    my $data = Daje::Workflow::Database::Model::Workflow->new(
        db            => $self->db,
        workflow_pkey => $self->workflow_pkey,
        workflow      => $self->workflow,
    )->load();

    return $data;
}

sub save_workflow($self, $data) {
    my $workflow_pkey = Daje::Workflow::Database::Model::Workflow->new(
        db => $self->db
    )->save(
        $data
    );
    return $workflow_pkey;
}

sub load_context($self) {
    my $data = Daje::Workflow::Database::Model::Context->new(
        db => $self->db,
        workflow_pkey => $self->workflow_pkey
    )->load_fk();

    return $data;
}

sub save_context($self, $data) {
    Daje::Workflow::Database::Model::Context->new(
        db => $self->db
    )->save(
        $self->context
    );
    return ;
}
1;
__END__

=encoding utf-8

=head1 NAME

Daje::Workflow::Database::Model - It's new $module

=head1 SYNOPSIS

    use Daje::Workflow::Database::Model;

=head1 DESCRIPTION

Daje::Workflow::Database::Model is ...

=head1 LICENSE

Copyright (C) janeskil1525.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

janeskil1525 E<lt>janeskil1525@gmail.comE<gt>

=cut

