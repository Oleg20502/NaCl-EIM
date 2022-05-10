#!/usr/bin/bash

TOKEN='5232246878:AAH2F0ahSUavW9Q_-ufAQpTHf4m2zPTf_ao'
CHATID='890953180'

squeue > squeue.txt
finish=$(awk -f script.awk squeue.txt)
if [ ${finish} -eq 1 ]
then
	curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="Calculation finished!"
	crontab -r
fi
rm squeue.txt
