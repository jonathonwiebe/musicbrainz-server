package MusicBrainz::Server::WebService::Serializer::JSON::2::Recording;
use Moose;
use MusicBrainz::Server::WebService::Serializer::JSON::2::Utils qw( serialize_entity );

extends 'MusicBrainz::Server::WebService::Serializer::JSON::2';
with 'MusicBrainz::Server::WebService::Serializer::JSON::2::Role::GID';
with 'MusicBrainz::Server::WebService::Serializer::JSON::2::Role::Rating';
# with 'MusicBrainz::Server::WebService::Serializer::JSON::2::Role::Relationships';
with 'MusicBrainz::Server::WebService::Serializer::JSON::2::Role::Tags';

sub element { 'recording'; }

sub serialize
{
    my ($self, $entity, $inc, $stash) = @_;
    my %body;

    my $opts = $stash->store ($entity);

    $body{title} = $entity->name;
    $body{disambiguation} = $entity->comment if $entity->comment;
    $body{length} = $entity->length if $entity->length;

    $body{isrcs} = [ map { $_->isrc } @{ $opts->{isrcs} } ] if $inc->isrcs;
    $body{puids} = [ map { $_->puid->puid } @{ $opts->{puids} } ] if $inc->puids;

    $body{"artist-credit"} = serialize_entity ($entity->artist_credit);

#     # TODO: releases.

    return \%body;
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;

# =head1 COPYRIGHT

# Copyright (C) 2011,2012 MetaBrainz Foundation

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# =cut
