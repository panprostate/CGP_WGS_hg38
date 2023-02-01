curl -sSL https://cpanmin.us/ > cpanm
perl cpanm --no-wget --no-interactive --notest --mirror http://cpan.metacpan.org -l $OPT App::cpanminus
