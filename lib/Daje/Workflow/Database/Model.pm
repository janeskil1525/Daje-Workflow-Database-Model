package Daje::Workflow::Database::Model;
use Mojo::Base -base, -signatures;

use Daje::Workflow::Database::Model::Workflow;
use Daje::Workflow::Database::Model::Context;
use Daje::Workflow::Database::Model::History;

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
#     $data->insert_history("History");
#
#     $data->save_context($context);
#
#     $data->save_workflow($workflow);
#
# REQUIRES
# ========
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
#  insert_history($self, $history_text, $class = " ", $internal =  1)
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

our $VERSION = "0.14";

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

sub insert_history($self, $history_text, $class = " ", $internal =  1) {
    return unless defined $history_text and length($history_text) > 0;

    my $history->{workflow_fkey} = $self->workflow_pkey();
    $history->{history} = $history_text;
    $history->{class} = $class;
    $history->{internal} = $internal;

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

    $data->insert_history("History");

    $data->save_context($context);

    $data->save_workflow($workflow);



=head1 REQUIRES


Mojo::Base




=head1 METHODS


 load($self)

 load_context($self)

 load_workflow($self)

 save_context($self)

 save_workflow($self, $workflow)

 insert_history($self, $history_text, $class = " ", $internal =  1)



=head1 AUTHOR


janeskil1525 E<lt>janeskil1525@gmail.comE<gt>



=head1 LICENSE


Copyright (C) janeskil1525.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.



=cut

