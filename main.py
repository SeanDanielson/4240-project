from netfilterqueue import NetfilterQueue
import scapy.all as scapy
from scapy.layers.inet import IP, TCP
import setproctitle
from datetime import datetime

# Set the process name
setproctitle.setproctitle('HttpFilter')

# Function that runs when a packet is intercepted.
# Checks if packet is http. If so, drop it.
def check_http(pkt):
    packet = scapy.IP(pkt.get_payload())
    if packet.haslayer(TCP) and (packet[TCP].sport == 80 or packet[TCP].dport == 80):
        pkt.drop()
        f = open("httptracker.log", "a")
        f.write(datetime.now().strftime('%d/%m/%Y %H:%M:%S') + '\n')
        f.close()
    else:
        pkt.accept()

# Instantiate netfilterqueue, bind it to queue 1 and the check_http function
nfqueue = NetfilterQueue()
nfqueue.bind(1, check_http)

# Start nfqueue to wait for packets
try:
    nfqueue.run()
except KeyboardInterrupt:
    print('')
    nfqueue.unbind()
    f.close()

