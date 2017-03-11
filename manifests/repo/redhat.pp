class nrpe::repo::redhat (
  $yum_repo = 'epel',
) {
  contain "::yum::repo::${yum_repo}"
}
