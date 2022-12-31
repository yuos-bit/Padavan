create hip1 hash:ip
add hip1 192.168.10.2
add hip1 192.168.10.3
create hip2 hash:ip hashsize 128 bucketsize 255 timeout 4
add hip2 192.168.10.3
add hip2 192.168.10.4 timeout 10
create hip3 hash:ip counters
add hip3 192.168.10.3 packets 5 bytes 3456
create hip4 hash:ip netmask 24
add hip4 192.168.10.0
create hip5 hash:ip maxelem 24
add hip5 192.168.10.0
create hip6 hash:ip comment
add hip5 192.168.10.1
add hip5 192.168.10.2 comment "this is a comment"
create ipp1 hash:ip,port
add ipp1 192.168.10.1,0
add ipp1 192.168.10.2,5
create ipp2 hash:ip,port timeout 4
add ipp2 192.168.10.1,0 timeout 12
add ipp2 192.168.10.2,5
create ipp3 hash:ip,port counters
add ipp3 192.168.10.3,20 packets 5 bytes 3456
create ipp4 hash:ip,port timeout 4 counters
add ipp4 192.168.10.3,20 packets 5 bytes 3456
create bip1 bitmap:ip range 2.0.0.1-2.1.0.1 timeout 5
create bip2 bitmap:ip range 10.0.0.0/8 netmask 24 timeout 5
add bip2 10.10.10.0
add bip2 10.10.20.0 timeout 12
create net1 hash:net
add net1 192.168.10.0/24
create net2 hash:net,net
add net2 192.168.10.0/24,192.168.20.0/24
create hm1 hash:mac
add hm1 aa:bb:cc:dd:ee:ff
create him1 hash:ip,mac
add him1 1.1.1.1,aa:bb:cc:dd:ee:ff
create ni1 hash:net,iface
add ni1 1.1.1.0/24,eth0
create nip1 hash:net,port
add nip1 1.1.1.0/24,22
create npn1 hash:net,port,net
add npn1 1.1.1.0/24,22,2.2.2.0/24
create nn1 hash:net,net
add nn1 1.1.1.0/24,2.2.2.0/24
create ipn1 hash:ip,port,net
add ipn1 1.1.1.1,22,2.2.2.0/24
create ipi1 hash:ip,port,ip
add ipi1 1.1.1.1,22,2.2.2.2
create im1 hash:ip,mark
add im1 1.1.1.1,0x123456
create bp1 bitmap:port range 1-1024
add bp1 22
create bim1 bitmap:ip,mac range 1.1.1.0/24
add bim1 1.1.1.1,aa:bb:cc:dd:ee:ff
create hn6 hash:net family inet6
add hn6 fe80::/64
