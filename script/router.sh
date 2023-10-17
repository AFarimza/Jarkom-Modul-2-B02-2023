#!/bin/bash
router() {
        iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.55.0.0/16
}