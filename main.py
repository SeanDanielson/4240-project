from netfilterqueue import NetfilterQueue
import scapy.all as scapy
from scapy.layers.inet import IP, TCP
import setproctitle
from datetime import datetime

setproctitle.setproctitle('HttpFilter')
f = open("httptracker.log", "w")
def print_and_accept(pkt):
    packet = scapy.IP(pkt.get_payload())
    if packet.haslayer(TCP) and (packet[TCP].sport == 80 or packet[TCP].dport == 80):
        pkt.drop()
        f = open("httptracker.log", "a")
        f.write(datetime.now().strftime('%d/%m/%Y %H:%M:%S') + '\n')
        f.close()
    else:
        pkt.accept()

nfqueue = NetfilterQueue()
nfqueue.bind(1, print_and_accept)
try:
    nfqueue.run()
except KeyboardInterrupt:
    print('')
    nfqueue.unbind()
    f.close()

