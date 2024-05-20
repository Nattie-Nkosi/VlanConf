## 1. Configure the switch interfaces connected to PCs as access ports in the correct VLAN.

# For Switch1
Switch1> enable
Switch1# configure terminal

! Configure F0/1 for PC1 (VLAN 10)
Switch1(config)# interface fastEthernet 0/1
Switch1(config-if)# switchport mode access
Switch1(config-if)# switchport access vlan 10
Switch1(config-if)# exit

! Configure F0/2 for PC2 (VLAN 10)
Switch1(config)# interface fastEthernet 0/2
Switch1(config-if)# switchport mode access
Switch1(config-if)# switchport access vlan 10
Switch1(config-if)# exit

! Configure F0/3 for PC3 (VLAN 30)
Switch1(config)# interface fastEthernet 0/3
Switch1(config-if)# switchport mode access
Switch1(config-if)# switchport access vlan 30
Switch1(config-if)# exit

! Configure F0/4 for PC4 (VLAN 30)
Switch1(config)# interface fastEthernet 0/4
Switch1(config-if)# switchport mode access
Switch1(config-if)# switchport access vlan 30
Switch1(config-if)# exit

# For Switch2
Switch2> enable
Switch2# configure terminal

! Configure F0/1 for PC5 (VLAN 20)
Switch2(config)# interface fastEthernet 0/1
Switch2(config-if)# switchport mode access
Switch2(config-if)# switchport access vlan 20
Switch2(config-if)# exit

! Configure F0/2 for PC6 (VLAN 10)
Switch2(config)# interface fastEthernet 0/2
Switch2(config-if)# switchport mode access
Switch2(config-if)# switchport access vlan 10
Switch2(config-if)# exit

! Configure F0/3 for PC7 (VLAN 10)
Switch2(config)# interface fastEthernet 0/3
Switch2(config-if)# switchport mode access
Switch2(config-if)# switchport access vlan 10
Switch2(config-if)# exit

## 2. Configure the connection between SW1 and SW2 as a trunk, allowing only the necessary VLANs. Configure an unused VLAN as the native VLAN.

# For Switch SW1:
Switch1(config)# interface gigabitEthernet 0/1
Switch1(config-if)# switchport mode trunk
Switch1(config-if)# switchport trunk allowed vlan 10,20,30
Switch1(config-if)# switchport trunk native vlan 99
Switch1(config-if)# exit

# For Switch SW2:
Switch2(config)# interface gigabitEthernet 0/1
Switch2(config-if)# switchport mode trunk
Switch2(config-if)# switchport trunk allowed vlan 10,20,30
Switch2(config-if)# switchport trunk native vlan 99
Switch2(config-if)# exit

## Ensure all necessary VLANs exist on each switch:

# For Switch SW1:
Switch1(config)# vlan 10
Switch1(config-vlan)# exit
Switch1(config)# vlan 20
Switch1(config-vlan)# exit
Switch1(config)# vlan 30
Switch1(config-vlan)# exit
Switch1(config)# vlan 99
Switch1(config-vlan)# exit

# For Switch SW2:
Switch2(config)# vlan 10
Switch2(config-vlan)# exit
Switch2(config)# vlan 20
Switch2(config-vlan)# exit
Switch2(config)# vlan 30
Switch2(config-vlan)# exit
Switch2(config)# vlan 99
Switch2(config-vlan)# exit

## 3. Configure the connection between SW2 and R1 using 'router on a stick'.

# On Switch SW2:
Switch2(config)# interface gigabitEthernet 0/2
Switch2(config-if)# switchport mode trunk
Switch2(config-if)# switchport trunk allowed vlan 10,20,30
Switch2(config-if)# switchport trunk native vlan 99
Switch2(config-if)# exit

# On Router R1:
Router> enable
Router# configure terminal

! Create subinterfaces for each VLAN
Router(config)# interface gigabitEthernet 0/0.10
Router(config-subif)# encapsulation dot1Q 10
Router(config-subif)# ip address 10.0.0.1 255.255.255.192
Router(config-subif)# exit

Router(config)# interface gigabitEthernet 0/0.20
Router(config-subif)# encapsulation dot1Q 20
Router(config-subif)# ip address 10.0.0.65 255.255.255.192
Router(config-subif)# exit

Router(config)# interface gigabitEthernet 0/0.30
Router(config-subif)# encapsulation dot1Q 30
Router(config-subif)# ip address 10.0.0.129 255.255.255.192
Router(config-subif)# exit

! Enable the physical interface
Router(config)# interface gigabitEthernet 0/0
Router(config-if)# no shutdown
Router(config-if)# exit
