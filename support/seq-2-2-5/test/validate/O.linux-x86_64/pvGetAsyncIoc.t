$ENV{HARNESS_ACTIVE} = 1;
$ENV{TOP} = '/home/vasu/synApps/support/seq-2-2-5';
$ENV{PATH} = '/home/vasu/synApps/support/seq-2-2-5/bin/linux-x86_64:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin';
$ENV{EPICS_CA_SERVER_PORT} = 10000 + $$ % 30000;
#only for debugging:
#print STDERR "port=$ENV{EPICS_CA_SERVER_PORT}\n";
my $pid = fork();
die "fork failed: $!" unless defined($pid);
if (!$pid) {
  exec("./pvGetAsync -S -d ../pvGetAsync.db");
  die "exec failed: $!";
}
system("./pvGetAsync -S -t");
kill 9, $pid or die "kill failed: $!";
