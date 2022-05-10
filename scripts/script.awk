BEGIN{
finish=1
}

{
if ($3=="lmp_mpi") { finish=0; }
}

END{
print finish
}
