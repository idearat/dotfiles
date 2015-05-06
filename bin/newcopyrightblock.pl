die "File $ARGV[0] doesn't exist." unless -e $ARGV[0];
die "File $ARGV[0] isn't a .js file." unless $ARGV[0]=~/\.js$/;
$art="//  ========================================================================";
$pre_copyright="$art
/**
";
$copyright=" * \@copyright Copyright (C) 1999 Technical Pursuit Inc. (TPI) All Rights
 *     Reserved. Patents Pending, Technical Pursuit Inc. Licensed under the
 *     OSI-approved Reciprocal Public License (RPL) Version 1.5. See the RPL
 *     for your rights and responsibilities. Contact TPI to purchase optional
 *     privacy waivers if you must keep your TIBET-based source code private.
 */
";
@lines=`cat $ARGV[0]`;
$state=0;
while($_=shift @lines){
	&{[\&pre,\&possible,\&overview,\&copyright_block]->[$state]};
	push @{[\@pre,\@possible,\@overview,\@copyright_block,\@post]->[$state]},$_ unless $is_art;
	last if $state == 4;
}
$overview=join '',@overview;
$overview=~s/\@fileoverview/\@overview/;
$overivew=~s/.*\@overview/ * \@overview/;
$copyright_block="$pre_copyright$overview$copyright";
if(@post){
	push @pre,$copyright_block;
}else{
	unshift @pre,$copyright_block;
}
shift @lines if is_art($lines[0]);
print @pre;
print @post;
print @lines;
sub pre{
	if(is_art()){
		$is_art=1;
	}elsif(is_start()){
		$state=1;
	}
}
sub is_art{
	/^\s*\/\/\s*=+\s*/
}
sub is_start{
	/^\s*\/\*+\s*$/
}
sub possible{
	if(is_overview()){
		$state=2;
	}elsif(is_copyright()){
		$state=3;
	}elsif(is_end()){
		push @pre,@possible;
		undef @possible;
		$state=0;
	}
}
sub is_overview{
	/(\@overview|\@fileoverview)\b/
}
sub is_end{
	/\*\//
}
sub overview{
	if(is_jdoc_line()){
		$state=3
	}elsif(is_end()){
		undef $_;
		$state=4
	}
}
sub is_jdoc_line{
	/\@[a-zA-Z0-9_-]+/
}
sub is_copyright{
	/\@copyright|Copyright.*Technical Pursuit/
}
sub copyright_block{
	if(is_overview()){
		$state=2
	}elsif(is_end()){
		undef $_;
		$state=4
	}
}


