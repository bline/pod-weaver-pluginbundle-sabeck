use strict;
use warnings;
package Pod::Weaver::PluginBundle::SABECK;
# ABSTRACT: SABECK's default Pod::Weaver config


use Pod::Weaver::Config::Assembler;
sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }

sub mvp_bundle_config {
  my @plugins;
  push @plugins, (
    [ '@SABECK/CorePrep',    _exp('@CorePrep'), {} ],
    [ '@SABECK/Name',        _exp('Name'),      {} ],
    [ '@SABECK/Version',     _exp('Version'),   {} ],

    [ '@SABECK/Prelude',     _exp('Region'),  { region_name => 'prelude'     } ],
    [ '@SABECK/Synopsis',    _exp('Generic'), { header      => 'SYNOPSIS'    } ],
    [ '@SABECK/Description', _exp('Generic'), { header      => 'DESCRIPTION' } ],
    [ '@SABECK/Overview',    _exp('Generic'), { header      => 'OVERVIEW'    } ],

    [ '@SABECK/Stability',   _exp('Generic'), { header      => 'STABILITY'   } ],
  );

  for my $plugin (
    [ 'Types',            _exp('Collect'), { command => 'type'     } ],
    [ 'Class Attributes', _exp('Collect'), { command => 'clattr'   } ],
    [ 'Class Methods',    _exp('Collect'), { command => 'clmethod' } ],
    [ 'Attributes',       _exp('Collect'), { command => 'attr'     } ],
    [ 'Methods',          _exp('Collect'), { command => 'method'   } ],
    [ 'Functions',        _exp('Collect'), { command => 'func'     } ],
  ) {
    $plugin->[2]{header} = uc $plugin->[0];
    push @plugins, $plugin;
  }

  push @plugins, (
    [ '@SABECK/Leftovers', _exp('Leftovers'), {} ],
    [ '@SABECK/postlude',  _exp('Region'),    { region_name => 'postlude' } ],
    [ '@SABECK/Authors',   _exp('Authors'),   {} ],
    [ '@SABECK/Legal',     _exp('Legal'),     {} ],
    [ '@SABECK/List',      _exp('-Transformer'), { 'transformer' => 'List' } ],
  );

  return @plugins;
}

=head1 NAME

Pod::Weaver::PluginBundle::SABECK - SABECK's default Pod::Weaver config

=head1 OVERVIEW

Copy of RJBS plugin bundle with the following commands/sections:

    Command     Section             Usage
    -------------------------------------
    =type       TYPES               MooseX::Types files
    =clattr     CLASS ATTRIBUTES    MooseX::ClassAttribute attributes
    =clmethod   CLASS METHODS       class methods

=back

1;

