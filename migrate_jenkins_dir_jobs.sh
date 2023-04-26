list_of_jobs=$(java -jar jenkins-cli.jar -s <SOURCE-JENKINS-URL> -auth <SOURCE-JENKINS-USERNAME>:<SOURCE-JENKINS-PASSWORD>  list-jobs <SOURCE-JOB-PATH>)
$(echo "$list_of_jobs" > all_jobs.txt )

for val in $(cat all_jobs.txt); do
 echo "------------------Migrating: $val---------------------"
 $(java -jar jenkins-cli.jar -s <SOURCE-JENKINS-URL> -auth <SOURCE-JENKINS-USERNAME>:<SOURCE-JENKINS-PASSWORD> get-job "<SOURCE-JOB-PATH>/$val" | pbcopy) 
 $(pbpaste | java -jar jenkins-cli.jar -s <DESTINATION-JENKINS-URL> -auth <DESTINATION-JENKINS-USERNAME>:<DESTINATION-JENKINS-PASSWORD>  create-job "<DESTINATION-JOB-PATH>/$val") #${val##*/}
 echo "------------------Migration complete for: $val---------------------"
done


