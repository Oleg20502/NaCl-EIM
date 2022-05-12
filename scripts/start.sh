#!/usr/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="lammps"
#SBATCH --get-user-env
#SBATCH --partition=RT
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --exclusive
#SBATCH --comment="infa 2022"

TOKEN='5232246878:AAH2F0ahSUavW9Q_-ufAQpTHf4m2zPTf_ao'
CHATID='890953180'

cd ~/NaCl-EIM
crontab scripts/crontab.sh

mkdir -p log/
mkdir -p rdf/
mkdir -p dump/
mkdir -p png/

curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="Started"

for temp in 600 700 800 900 1000 1100 1200 1300 1400 1500 1600
do
	sed "s/YYYYTEMP/$temp/g" input/in.eim_raw > in.eim_for_run
	srun --exclusive -N 1 -p RT --ntasks-per-node=8 ~/bin/lmp_mpi -in in.eim_for_run > log/log.lammps_$temp

	sed "s/YYYYTEMP/$temp/g" scripts/script.gnuplot > script_temp.gnuplot
	gnuplot script_temp.gnuplot
	rm script_temp.gnuplot

	curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendPhoto -F chat_id=${CHATID} -F photo="@png/rdf_${temp}.png" -F caption="Temp: $temp finished"
	rm in.eim_for_run
	echo "Temp: $temp finished"
done
rm log.lammps

