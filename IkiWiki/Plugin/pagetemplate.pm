#!/usr/bin/perl
package IkiWiki::Plugin::pagetemplate;

use warnings;
use strict;
use IkiWiki 2.00;

my %templates;

sub import { #{{{
	hook(type => "preprocess", id => "pagetemplate", call => \&preprocess);
	hook(type => "templatefile", id => "pagetemplate", call => \&templatefile);
} # }}}

sub preprocess (@) { #{{{
	my %params=@_;

	if (! exists $params{template} ||
	    $params{template} !~ /^[-A-Za-z0-9._+]+$/ ||
	    ! defined IkiWiki::template_file($params{template})) {
		 return "[[pagetemplate ".gettext("bad or missing template")."]]";
	}

	if ($params{page} eq $params{destpage}) {
		$templates{$params{page}}=$params{template};
	}

	return "";
} # }}}

sub templatefile (@) { #{{{
	my %params=@_;

	if (exists $templates{$params{page}}) {
		return $templates{$params{page}};
	}
	
	return undef;
} # }}}

1
