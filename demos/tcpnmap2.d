#!/usr/sbin/dtrace -s
tcp:::accept-refused
{
 trace("Refused -- :)");
 trace(args[2]->ip_daddr);trace(args[4]->tcp_sport);
}
tcp:::receive
/args[4]->tcp_flags == 0/
{
	trace("Flag 0");
	trace(args[2]->ip_saddr);trace(args[3]->tcps_lport);trace(args[4]->tcp_flags);
}
tcp:::receive
/*/args[4]->tcp_flags != 0/
*(TH_RST|TH_ECE|TH_CWR|TH_URG|TH_PUSH|TH_FIN|TH_SYN|TH_ACK)
*/{
    printf("%s", args[4]->tcp_flags & TH_FIN ? "FIN|" : "");
    printf("%s", args[4]->tcp_flags & TH_SYN ? "SYN|" : "");
    printf("%s", args[4]->tcp_flags & TH_RST ? "RST|" : "");
    printf("%s", args[4]->tcp_flags & TH_PUSH ? "PUSH|" : "");
    printf("%s", args[4]->tcp_flags & TH_ACK ? "ACK|" : "");
    printf("%s", args[4]->tcp_flags & TH_URG ? "URG|" : "");
    printf("%s", args[4]->tcp_flags & TH_ECE ? "ECE|" : "");
    printf("%s", args[4]->tcp_flags & TH_CWR ? "CWR|" : "");
    printf("%s", args[4]->tcp_flags == 0 ? "null " : "");
    printf("\b)\n");
}
