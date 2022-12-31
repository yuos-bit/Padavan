# Create a set with timeout
0 ipset create test hash:net,net hashsize 128 timeout 4
# Add zero valued element
1 ipset add test 0.0.0.0/0,0.0.0.0/0
# Test zero valued element
1 ipset test test 0.0.0.0/0,0.0.0.0/0
# Delete zero valued element
1 ipset del test 0.0.0.0/0,0.0.0.0/0
# Try to add /0
1 ipset add test 1.1.1.1/0,1.1.1.1/0
# Try to add /32
0 ipset add test 1.1.1.1/32,1.1.1.2/32
# Add almost zero valued element
0 ipset add test 0.0.0.0/1,0.0.0.0/1
# Test almost zero valued element
0 ipset test test 0.0.0.0/1,0.0.0.0/1
# Delete almost zero valued element
0 ipset del test 0.0.0.0/1,0.0.0.0/1
# Test deleted element
1 ipset test test 0.0.0.0/1,0.0.0.0/1
# Delete element not added to the set
1 ipset del test 0.0.0.0/1,0.0.0.0/1
# Add first random network
0 ipset add test 2.0.0.1/24,2.0.1.1/24
# Add second random network
0 ipset add test 192.168.68.69/27,192.168.129.69/27
# Test first random value
0 ipset test test 2.0.0.255,2.0.1.255
# Test second random value
0 ipset test test 192.168.68.95,192.168.129.75
# Test value not added to the set
1 ipset test test 2.0.1.0,2.0.0.1
# Try to add IP address
0 ipset add test 2.0.0.1,2.0.0.2
# List set
0 ipset list test > .foo0 && ./sort.sh .foo0
# Check listing
0 ./diff.sh .foo hash:net,net.t.list0
# Sleep 5s so that element can time out
0 sleep 5
# List set
0 ipset -L test > .foo0 && ./sort.sh .foo0
# Check listing
0 ./diff.sh .foo hash:net,net.t.list1
# Flush test set
0 ipset flush test
# Delete test set
0 ipset destroy test
# Create test set
0 ipset new test hash:net,net
# Add networks in range notation
0 ipset add test 10.2.0.0-10.2.1.12,10.3.0.0-10.3.1.12
# List set
0 ipset -L test > .foo0 && ./sort.sh .foo0
# Check listing
0 ./diff.sh .foo hash:net,net.t.list2
# Delete test set
0 ipset destroy test
# Stress test with range notation
0 ./netnetgen.sh | ipset restore
# List set and check the number of elements
0 n=`ipset -L test|grep '^10.'|wc -l` && test $n -eq 87040
# Destroy test set
0 ipset destroy test
# Create test set with timeout support
0 ipset create test hash:net,net timeout 30
# Add a non-matching IP address entry
0 ipset -A test 1.1.1.1,1.1.1.2 nomatch
# Add an overlapping matching small net
0 ipset -A test 1.1.1.0/30,1.1.1.0/30
# Add an overlapping non-matching larger net
0 ipset -A test 1.1.1.0/28,1.1.1.0/28 nomatch
# Add an even larger matching net
0 ipset -A test 1.1.1.0/26,1.1.1.0/26
# Check non-matching IP
1 ipset -T test 1.1.1.1,1.1.1.2
# Check matching IP from non-matchin small net
0 ipset -T test 1.1.1.3,1.1.1.2
# Check non-matching IP from larger net
1 ipset -T test 1.1.1.4,1.1.1.4
# Check matching IP from even larger net
0 ipset -T test 1.1.1.16,1.1.1.16
# Update non-matching IP to matching one
0 ipset -! -A test 1.1.1.1,1.1.1.2
# Delete overlapping small net
0 ipset -D test 1.1.1.0/30,1.1.1.0/30
# Check matching IP
0 ipset -T test 1.1.1.1,1.1.1.2
# Add overlapping small net
0 ipset -A test 1.1.1.0/30,1.1.1.0/30
# Update matching IP as a non-matching one, with shorter timeout
0 ipset -! -A test 1.1.1.1,1.1.1.2 nomatch timeout 2
# Check non-matching IP
1 ipset -T test 1.1.1.1,1.1.1.2
# Sleep 3s so that element can time out
0 sleep 3
# Check non-matching IP
0 ipset -T test 1.1.1.1,1.1.1.2
# Check matching IP
0 ipset -T test 1.1.1.3,1.1.1.2
# flush ipset
0 ipset -F test
# Add matching IP
0 ipset -A test 10.0.0.0/16,192.168.0.0/24
# Add more-specific non-matching IP
0 ipset -A test 10.0.0.0/24,192.168.0.0/24 nomatch
# Add even more-specific matching IP
0 ipset -A test 10.0.0.0/30,192.168.0.0/23
# Check non-matching IP
1 ipset -T test 10.0.0.10,192.168.0.1
# Check non-matching IP with nomatch specified
0 ipset -T test 10.0.0.10,192.168.0.1 nomatch
# Check matching IP
0 ipset -T test 10.0.0.1,192.168.0.1
# Delete test set
0 ipset destroy test
# Timeout: Check that resizing keeps timeout values
0 ./resizet.sh -4 netnet
# Nomatch: Check that resizing keeps the nomatch flag
0 ./resizen.sh -4 netnet
# Counters: create set
0 ipset n test hash:net,net counters
# Counters: add element with packet, byte counters
0 ipset a test 2.0.0.1/24,2.0.0.1/24 packets 5 bytes 3456
# Counters: check element
0 ipset t test 2.0.0.1/24,2.0.0.1/24
# Counters: check counters
0 ./check_counters test 2.0.0.0/24,2.0.0.0/24 5 3456
# Counters: delete element
0 ipset d test 2.0.0.1/24,2.0.0.1/24
# Counters: test deleted element
1 ipset t test 2.0.0.1/24,2.0.0.1/24
# Counters: add element with packet, byte counters
0 ipset a test 2.0.0.20/25,2.0.0.20/25 packets 12 bytes 9876
# Counters: check counters
0 ./check_counters test 2.0.0.0/25,2.0.0.0/25 12 9876
# Counters: update counters
0 ipset -! a test 2.0.0.20/25,2.0.0.20/25 packets 13 bytes 12479
# Counters: check counters
0 ./check_counters test 2.0.0.0/25,2.0.0.0/25 13 12479
# Counters: destroy set
0 ipset x test
# Counters and timeout: create set
0 ipset n test hash:net,net counters timeout 600
# Counters and timeout: add element with packet, byte counters
0 ipset a test 2.0.0.1/24,2.0.0.1/24 packets 5 bytes 3456
# Counters and timeout: check element
0 ipset t test 2.0.0.1/24,2.0.0.1/24
# Counters and timeout: check counters
0 ./check_extensions test 2.0.0.0/24,2.0.0.0/24 600 5 3456
# Counters and timeout: delete element
0 ipset d test 2.0.0.1/24,2.0.0.1/24
# Counters and timeout: test deleted element
1 ipset t test 2.0.0.1/24,2.0.0.1/24
# Counters and timeout: add element with packet, byte counters
0 ipset a test 2.0.0.20/25,2.0.0.20/25 packets 12 bytes 9876
# Counters and timeout: check counters
0 ./check_extensions test 2.0.0.0/25,2.0.0.0/25 600 12 9876
# Counters and timeout: update counters
0 ipset -! a test 2.0.0.20/25,2.0.0.20/25 packets 13 bytes 12479
# Counters and timeout: check counters
0 ./check_extensions test 2.0.0.0/25,2.0.0.0/25 600 13 12479
# Counters and timeout: update timeout
0 ipset -! a test 2.0.0.20/25,2.0.0.20/25 timeout 700
# Counters and timeout: check counters
0 ./check_extensions test 2.0.0.0/25,2.0.0.0/25 700 13 12479
# Counters and timeout: destroy set
0 ipset x test
# Network: Create a set with timeout and netmask
0 ipset -N test hash:net,net --hashsize 128 --netmask 24 timeout 4
# Network: Add first random network
0 ipset -A test 2.0.10.1,2.10.10.254
# Network: Add second random network
0 ipset -A test 192.168.68.1,192.168.68.254
# Network: Test first random value
0 ipset -T test 2.0.10.11,2.10.10.25
# Network: Test second random value
0 ipset -T test 192.168.68.11,192.168.68.5
# Network: Test value not added to the set
1 ipset -T test 2.10.1.0,21.0.1.0
# Network: Add third element
0 ipset -A test 200.100.10.1,200.100.10.100 timeout 0
# Network: Add third random network
0 ipset -A test 200.100.0.12,200.100.0.13
# Network: Delete the same network
0 ipset -D test 200.100.0.12,200.100.0.13
# Network: List set
0 ipset -L test > .foo0 && ./sort.sh .foo0
# Network: Check listing
0 ./diff.sh .foo hash:net,net.t.list3
# Sleep 5s so that elements can time out
0 sleep 5
# Network: List set
0 ipset -L test > .foo
# Network: Check listing
0 ./diff.sh .foo hash:net,net.t.list4
# Network: Flush test set
0 ipset -F test
# Network: add element with 1s timeout
0 ipset add test 200.100.0.12,80.20.0.12 timeout 1
# Network: readd element with 3s timeout
0 ipset add test 200.100.0.12,80.20.0.12 timeout 3 -exist
# Network: sleep 2s
0 sleep 2s
# Network: check readded element
0 ipset test test 200.100.0.12,80.20.0.12
# Network: Delete test set
0 ipset -X test
# Network: Create a set with timeout and bitmask
0 ipset -N test hash:net,net --hashsize 128 --bitmask 255.255.255.0 timeout 4
# Network: Add first random network
0 ipset -A test 2.0.10.1,2.10.10.254
# Network: Add second random network
0 ipset -A test 192.168.68.1,192.168.68.254
# Network: Test first random value
0 ipset -T test 2.0.10.11,2.10.10.25
# Network: Test second random value
0 ipset -T test 192.168.68.11,192.168.68.5
# Network: Test value not added to the set
1 ipset -T test 2.10.1.0,21.0.1.0
# Network: Add third element
0 ipset -A test 200.100.10.1,200.100.10.100 timeout 0
# Network: Add third random network
0 ipset -A test 200.100.0.12,200.100.0.13
# Network: Delete the same network
0 ipset -D test 200.100.0.12,200.100.0.13
# Network: List set
0 ipset -L test > .foo0 && ./sort.sh .foo0
# Network: Check listing
0 ./diff.sh .foo hash:net,net.t.list5
# Sleep 5s so that elements can time out
0 sleep 5
# Network: List set
0 ipset -L test > .foo
# Network: Check listing
0 ./diff.sh .foo hash:net,net.t.list6
# Network: Flush test set
0 ipset -F test
# Network: add element with 1s timeout
0 ipset add test 200.100.0.12,80.20.0.12 timeout 1
# Network: readd element with 3s timeout
0 ipset add test 200.100.0.12,80.20.0.12 timeout 3 -exist
# Network: sleep 2s
0 sleep 2s
# Network: check readded element
0 ipset test test 200.100.0.12,80.20.0.12
# Network: Delete test set
0 ipset -X test
# Network: Create a set with bitmask which is not a valid netmask
0 ipset -N test hash:net,net --hashsize 128 --bitmask 255.255.0.255
# Network: Add zero valued element
1 ipset -A test 0.0.0.0
# Network: Test zero valued element
1 ipset -T test 0.0.0.0
# Network: Delete zero valued element
1 ipset -D test 0.0.0.0
# Network: Add first random network
0 ipset -A test 1.2.3.4,22.23.24.25
# Network: Add second random network
0 ipset -A test 1.168.122.124,122.23.45.50
# Network: Test first random value
0 ipset -T test 1.2.43.4,22.23.2.25
# Network: Test second random value
0 ipset -T test 1.168.12.124,122.23.4.50
# Network: Test value not added to the set
1 ipset -T test 2.168.122.124,22.23.45.50
# Network: Test delete value
0 ipset -D test 1.168.12.124,122.23.0.50
# Network: List set
0 ipset -L test > .foo
# Network: Check listing
0 ./diff.sh .foo hash:net,net.t.list7
# Network: Delete test set
0 ipset -X test
# eof
