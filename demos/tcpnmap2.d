#!/usr/sbin/dtrace -s

dtrace:::BEGIN
{
	printf("tracing for possible nmap scans ....\n")
}
tcp:::receive
/args[4]->tcp_flags == 0/
{
  printf("TCP_null_scan ....\n")
	trace(args[2]->ip_saddr);trace(args[3]->tcps_lport);
}
tcp:::receive
/args[4]->tcp_flags == (TH_RST||TH_ECE||TH_CWR||TH_URG||TH_PUSH||TH_FIN||TH_SYN||TH_ACK)/
{
  printf("TCP_Xmas_scan ....\n")
  trace(args[2]->ip_saddr);trace(args[3]->tcps_lport]);
}
