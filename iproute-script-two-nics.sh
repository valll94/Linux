#! /bin/bash
while true 		# use loop, because on every 1200-1800 seconds, DHCP make renew
do

N=1   			# constant, which is used in “awk” command. 1 is first word in the line	
i=1			# “i” is the line of ip route output
M=3			# constant, which is used in “awk” command. 3 is third word in the line

ip -o route | while read line	# read “ip route” output for every line 
do

subnet["$i"]="$( ip -o route | awk -v N="$N" 'NR=='$i' {print $N }' )"	       # gets the IP in “i” line
subnet["$n"]="$( ip -o route | awk -v M="$M" 'NR=='$i' {print $M }' )"        # device interface( eth0,1 etc.)

if [ "${subnet[n]}" != "eth0" ] ||  "${subnet[i]}" == "${subnet[i-1]}" ] && [ "${subnet[i]}" != "" ] &&
   [ "${subnet[i]}" != "default" ]; then			 	# check devices and IPs

          ip route delete "${subnet[i]}" dev "${subnet[n]}"	# delete the “network” line in “ip route” table 
#        ip route delete default dev "${subnet[n]}"		# delete the default gateway for second interface
# The code works without the line for default gateway. I am not really sure how is better. My idea was: without this line should be work eth1, when I stopped eth0, but actually it doesn’t works.

fi 		# end of Conditional


i=$((i+1))   	# In the end of the loop I add +1 to “i” variable to read the next line of “ip route” output

done                # end of the loop


sleep 300 	# you can found explanation for this line below ( problem 2 )
done
