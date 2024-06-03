#!/bin/bash

# Multilayer Switch 3650 Configuration
echo "Configuring Multilayer Switch 3650..."
(
echo "enable"
echo "configure terminal"

# VLAN 1
echo "interface vlan 1"
echo "ip address 10.1.1.254 255.255.255.0"
echo "no shutdown"
echo "exit"

# VLAN 10
echo "interface vlan 10"
echo "ip address 10.1.10.254 255.255.255.0"
echo "no shutdown"
echo "exit"

# VLAN 20
echo "interface vlan 20"
echo "ip address 10.1.20.254 255.255.255.0"
echo "no shutdown"
echo "exit"

# VLAN 30
echo "interface vlan 30"
echo "ip address 10.1.30.254 255.255.255.0"
echo "no shutdown"
echo "exit"

# VLAN 100
echo "interface vlan 100"
echo "ip address 10.1.100.254 255.255.255.0"
echo "no shutdown"
echo "exit"

# Enable IP Routing
echo "ip routing"
echo "exit"
) | telnet <IP_of_Multilayer_Switch>

# Switch 1 Configuration
echo "Configuring Switch 1..."
(
echo "enable"
echo "configure terminal"

# Management VLAN 1
echo "interface vlan 1"
echo "ip address 10.1.1.1 255.255.255.0"
echo "no shutdown"
echo "exit"

# Access Port for PC1 (VLAN 10)
echo "interface fastEthernet 0/1"
echo "switchport mode access"
echo "switchport access vlan 10"
echo "exit"

# Trunk Port to Multilayer Switch
echo "interface gigabitEthernet 0/1"
echo "switchport mode trunk"
echo "switchport trunk allowed vlan 10,20,30,100"
echo "exit"
) | telnet <IP_of_Switch_1>

# Switch 2 Configuration
echo "Configuring Switch 2..."
(
echo "enable"
echo "configure terminal"

# Management VLAN 1
echo "interface vlan 1"
echo "ip address 10.1.1.2 255.255.255.0"
echo "no shutdown"
echo "exit"

# Access Port for PC2 (VLAN 20)
echo "interface fastEthernet 0/1"
echo "switchport mode access"
echo "switchport access vlan 20"
echo "exit"

# Trunk Port to Multilayer Switch
echo "interface gigabitEthernet 0/1"
echo "switchport mode trunk"
echo "switchport trunk allowed vlan 10,20,30,100"
echo "exit"
) | telnet <IP_of_Switch_2>

# Switch 3 Configuration
echo "Configuring Switch 3..."
(
echo "enable"
echo "configure terminal"

# Management VLAN 1
echo "interface vlan 1"
echo "ip address 10.1.1.3 255.255.255.0"
echo "no shutdown"
echo "exit"

# Access Port for PC3 (VLAN 30)
echo "interface fastEthernet 0/1"
echo "switchport mode access"
echo "switchport access vlan 30"
echo "exit"

# Trunk Port to Multilayer Switch
echo "interface gigabitEthernet 0/1"
echo "switchport mode trunk"
echo "switchport trunk allowed vlan 10,20,30,100"
echo "exit"
) | telnet <IP_of_Switch_3>

# Verification
echo "Verifying Configuration..."
(
echo "enable"

# Verify Multilayer Switch 3650
echo "ping 10.1.10.10"
echo "ping 10.1.20.20"
echo "ping 10.1.30.30"
echo "ping 10.1.100.100"
echo "exit"
) | telnet <IP_of_Multilayer_Switch>

echo "Configuration completed. Please verify connectivity from each PC and Server."
