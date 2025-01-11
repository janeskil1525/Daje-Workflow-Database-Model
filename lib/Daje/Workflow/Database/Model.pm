package Daje::Workflow::Database::Model;
use Mojo::Base -base, -signatures;

use Daje::Workflow::Database::Model::Workflow;
use Daje::Workflow::Database::Model::Context;

# NAME
# ====
#
# Daje::Workflow::Database::Model - is the data models used by Daje-Workflow
#
# SYNOPSIS
# ========
#
#    use Daje::Workflow::Database::Model;
#
#    my $data = Daje::Workflow::Database::Model->new(
#         db            => $db,
#         workflow_pkey => $workflow_pkey,
#         workflow_name => $workflow_name,
#         context       => $context,
#     )->load();
#
#     my $workflow = $data->workflow();
#
#     my $context = $self->context();
#
#
# REQUIRES
# ========
#
# Daje::Workflow::Database::Model::Context
#
# Daje::Workflow::Database::Model::Workflow
#
# Mojo::Base
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
#  save_workflow($self, $workflow)
#
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

our $VERSION = "0.11";

has 'db';               # Constructor
has 'workflow_pkey';    # Constructor
has 'workflow_name';    # Constructor
has 'context';          # Constructor

has 'workflow_data';

sub load($self) {
    eval {
        $self->load_workflow();
        $self->load_context();
    };
    my $err = '';
    $err = $@ if defined $@;
    return $err;
}

sub load_workflow($self) {
    my $workflow = Daje::Workflow::Database::Model::Workflow->new(
        db            => $self->db,
        workflow_pkey => $self->workflow_pkey,
        workflow      => $self->workflow_name,
    )->load();
    $self->workflow_pkey($workflow->{workflow_pkey});
    $self->workflow_data($workflow);
    return;
}

sub save_workflow($self, $workflow) {
    my $workflow_pkey = Daje::Workflow::Database::Model::Workflow->new(
        db => $self->db
    )->save(
        $workflow
    );
    return $workflow_pkey;
}

sub load_context($self) {
    my $context = Daje::Workflow::Database::Model::Context->new(
        db            => $self->db,
        workflow_pkey => $self->workflow_pkey,
        context       => $self->context,
    )->load_fk();

    $self->context($context);
    return;
}

sub save_context($self, $context) {
    Daje::Workflow::Database::Model::Context->new(
        db              => $self->db,
        workflow_pkey   => $self->workflow_pkey,
    )->save(
        $context
    );
    $self->context($context);
    return ;
}

sub insert_history($self, $history) {
    Daje::Workflow::Database::Model::History->new(
        db => $self->db
    )->insert(
        $history
    );
}

1;
__END__







#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME


Daje::Workflow::Database::Model - is the data models used by Daje-Workflow



=head1 SYNOPSIS


   use Daje::Workflow::Database::Model;

   my $data = Daje::Workflow::Database::Model->new(
        db            => $db,
        workflow_pkey => $workflow_pkey,
        workflow_name => $workflow_name,
        context       => $context,
    )->load();

    my $workflow = $data->workflow();

    my $context = $self->context();




=head1 REQUIRES


Daje::Workflow::Database::Model::Context

Daje::Workflow::Database::Model::Workflow

Mojo::Base




=head1 METHODS


 load($self)

 load_context($self)

 load_workflow($self)

 save_context($self)

 save_workflow($self, $workflow)




=head1 AUTHOR


janeskil1525 E<lt>janeskil1525@gmail.comE<gt>



=head1 LICENSE


Copyright (C) janeskil1525.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.



=cut

