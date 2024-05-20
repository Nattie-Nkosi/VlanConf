# Network Configuration Documentation

## Overview

This document outlines the steps to configure VLANs, trunk ports, and Router on a Stick (ROAS) for the given network topology.

## Topology

- **VLAN 10 (10.0.0.0/26)**:
  - PCs: PC1 (10.0.0.1), PC2 (10.0.0.2), PC6 (10.0.0.4), PC7 (10.0.0.3)
- **VLAN 20 (10.0.0.64/26)**:
  - PC: PC5 (10.0.0.65)
- **VLAN 30 (10.0.0.128/26)**:
  - PCs: PC3 (10.0.0.129), PC4 (10.0.0.130)
- **Native VLAN**: VLAN 99 (Unused)

## Configuration Steps

### 1. Configure Switch Interfaces as Access Ports

#### Switch SW1

1. **Access Configuration Mode**

   ```sh
   Switch1> enable
   Switch1# configure terminal
   ```

2. **Configure F0/1 for PC1 (VLAN 10)**

   ```sh
   Switch1(config)# interface fastEthernet 0/1
   Switch1(config-if)# switchport mode access
   Switch1(config-if)# switchport access vlan 10
   Switch1(config-if)# exit
   ```

3. **Configure F0/2 for PC2 (VLAN 10)**

   ```sh
   Switch1(config)# interface fastEthernet 0/2
   Switch1(config-if)# switchport mode access
   Switch1(config-if)# switchport access vlan 10
   Switch1(config-if)# exit
   ```

4. **Configure F0/3 for PC3 (VLAN 30)**

   ```sh
   Switch1(config)# interface fastEthernet 0/3
   Switch1(config-if)# switchport mode access
   Switch1(config-if)# switchport access vlan 30
   Switch1(config-if)# exit
   ```

5. **Configure F0/4 for PC4 (VLAN 30)**
   ```sh
   Switch1(config)# interface fastEthernet 0/4
   Switch1(config-if)# switchport mode access
   Switch1(config-if)# switchport access vlan 30
   Switch1(config-if)# exit
   ```

#### Switch SW2

1. **Access Configuration Mode**

   ```sh
   Switch2> enable
   Switch2# configure terminal
   ```

2. **Configure F0/1 for PC5 (VLAN 20)**

   ```sh
   Switch2(config)# interface fastEthernet 0/1
   Switch2(config-if)# switchport mode access
   Switch2(config-if)# switchport access vlan 20
   Switch2(config-if)# exit
   ```

3. **Configure F0/2 for PC6 (VLAN 10)**

   ```sh
   Switch2(config)# interface fastEthernet 0/2
   Switch2(config-if)# switchport mode access
   Switch2(config-if)# switchport access vlan 10
   Switch2(config-if)# exit
   ```

4. **Configure F0/3 for PC7 (VLAN 10)**
   ```sh
   Switch2(config)# interface fastEthernet 0/3
   Switch2(config-if)# switchport mode access
   Switch2(config-if)# switchport access vlan 10
   Switch2(config-if)# exit
   ```

### 2. Configure Trunk Ports Between Switches

#### Switch SW1

1. **Configure G0/1 as Trunk Port**
   ```sh
   Switch1(config)# interface gigabitEthernet 0/1
   Switch1(config-if)# switchport mode trunk
   Switch1(config-if)# switchport trunk allowed vlan 10,20,30
   Switch1(config-if)# switchport trunk native vlan 99
   Switch1(config-if)# exit
   ```

#### Switch SW2

1. **Configure G0/1 as Trunk Port**
   ```sh
   Switch2(config)# interface gigabitEthernet 0/1
   Switch2(config-if)# switchport mode trunk
   Switch2(config-if)# switchport trunk allowed vlan 10,20,30
   Switch2(config-if)# switchport trunk native vlan 99
   Switch2(config-if)# exit
   ```

### 3. Ensure VLANs Exist on Both Switches

#### Switch SW1

1. **Create VLANs**
   ```sh
   Switch1(config)# vlan 10
   Switch1(config-vlan)# exit
   Switch1(config)# vlan 20
   Switch1(config-vlan)# exit
   Switch1(config)# vlan 30
   Switch1(config-vlan)# exit
   Switch1(config)# vlan 99
   Switch1(config-vlan)# exit
   ```

#### Switch SW2

1. **Create VLANs**
   ```sh
   Switch2(config)# vlan 10
   Switch2(config-vlan)# exit
   Switch2(config)# vlan 20
   Switch2(config-vlan)# exit
   Switch2(config)# vlan 30
   Switch2(config-vlan)# exit
   Switch2(config)# vlan 99
   Switch2(config-vlan)# exit
   ```

### 4. Configure Router on a Stick

#### Switch SW2

1. **Configure G0/2 as Trunk Port**
   ```sh
   Switch2(config)# interface gigabitEthernet 0/2
   Switch2(config-if)# switchport mode trunk
   Switch2(config-if)# switchport trunk allowed vlan 10,20,30
   Switch2(config-if)# switchport trunk native vlan 99
   Switch2(config-if)# exit
   ```

#### Router R1

1. **Access Configuration Mode**

   ```sh
   Router> enable
   Router# configure terminal
   ```

2. **Create Subinterfaces for Each VLAN**

   ```sh
   ! Subinterface for VLAN 10
   Router(config)# interface gigabitEthernet 0/0.10
   Router(config-subif)# encapsulation dot1Q 10
   Router(config-subif)# ip address 10.0.0.1 255.255.255.192
   Router(config-subif)# exit

   ! Subinterface for VLAN 20
   Router(config)# interface gigabitEthernet 0/0.20
   Router(config-subif)# encapsulation dot1Q 20
   Router(config-subif)# ip address 10.0.0.65 255.255.255.192
   Router(config-subif)# exit

   ! Subinterface for VLAN 30
   Router(config)# interface gigabitEthernet 0/0.30
   Router(config-subif)# encapsulation dot1Q 30
   Router(config-subif)# ip address 10.0.0.129 255.255.255.192
   Router(config-subif)# exit
   ```

3. **Enable Physical Interface**
   ```sh
   Router(config)# interface gigabitEthernet 0/0
   Router(config-if)# no shutdown
   Router(config-if)# exit
   ```

## Verification

1. **Check Subinterface Configuration on Router R1**

   ```sh
   Router# show ip interface brief
   ```

2. **Check Trunk Configuration on Switch SW1 and SW2**
   ```sh
   Switch1# show interfaces trunk
   Switch2# show interfaces trunk
   ```

By following these steps, you have configured the switches and the router, enabling VLAN management and inter-VLAN routing through the Router on a Stick configuration.
