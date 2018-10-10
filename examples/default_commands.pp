# default nrpe checks

include nrpe

nrpe::command {
  'check_users':
    command => 'check_users -w 5 -c 10';
  'check_load':
    command => 'check_load -w 15,10,5 -c 30,25,20';
  'check_hda1':
    command => 'check_disk -w 20% -c 10% -p /dev/hda1';
  'check_zombie_procs':
    command => 'check_procs -w 5 -c 10 -s Z';
  'check_total_procs':
    command => 'check_procs -w 150 -c 200'
}
