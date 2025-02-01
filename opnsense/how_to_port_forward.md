# Access Internal Webserver Externally and Internally with DNS Resolution

## Assumptions

- **External IP Address**: `123.45.67.89`
- **LAN Interface IP**: `192.168.10.1/24`
- **Webserver IP**: `192.168.10.30` (running HTTP on port 80 and HTTPS on port 443)
- **Domain**: `mysite.com`
- **DNS Record**: An A record for `www.mysite.com` points to `123.45.67.89` (your external IP address)

## Steps

### 1. Create Aliases to Simplify Configuration

1. **Navigate to**: `Firewall` -> `Aliases` -> `View`
2. **Click the "Add a new alias" button**.
3. **Enter the following information**:
    - **Type**: Host(s)
    - **Name**: `Webserver`
    - **Description**: `The webserver host`
    - **Host(s)**: `192.168.10.30`
    - **Description**: `Webserver IP address`
4. **Click Save**.
5. **Click the "Add a new alias" button again**.
6. **Enter the following information**:
    - **Type**: Port(s)
    - **Name**: `Websrv_Ports`
    - **Description**: `The webserver Ports`
    - **Port(s)**: `80`
    - **Description**: `HTTP port`
7. **Click the plus sign to add another line** and enter the following information:
    - **Port(s)**: `443`
    - **Description**: `HTTPS port`
8. **Click Save** and **Apply Settings**.

### 2. Change OPNsense Web GUI Port (Optional)

If you're forwarding both port 80 (HTTP) and port 443 (HTTPS), change the web GUI port for OPNsense to avoid conflicts. For example, set it to port 440.

1. **Navigate to**: `System` -> `Settings` -> `Administration`.
2. **Enter** `440` in the **TCP port** field.
3. **Click Save**.
4. The OPNsense web GUI will automatically reconnect in 20 seconds using the new port.

### 3. Add Port Forwarding Rule for Webserver

1. **Navigate to**: `Firewall` -> `NAT` -> `Port Forward`.
2. **Click the "Add" button** to create a new Port Forward rule.
3. **Select the following information**:
    - **Interface**: `WAN`
    - **TCP/IP version**: `IPv4`
    - **Protocol**: `TCP`
    - **Destination**: `WAN Address`
    - **Port range**:
        - **From**: `Websrv_Ports`
        - **To**: `Websrv_Ports`
    - **Redirect target IP**: `Webserver` (this alias will be available from the dropdown)
    - **Redirect target ports**: `Websrv_Ports`
    - **NAT reflection**: `Enable (Pure NAT)`
    - **Filter rule association**: `Add associated filter rule`
4. **Click Save** and **Apply Settings**.

## Expected Outcome

- The external DNS server will resolve `www.mysite.com` to your external IP address (`123.45.67.89`).
- The NAT/Port Forward rule will forward this traffic to your webserver (`192.168.10.30`).
- If internally `www.mysite.com` resolves to the external IP address, NAT Reflection will send the traffic back to your webserver internally.

---

I hope this helps you set up your internal webserver access both externally and internally! 

Kind regards,  
**Bert**










```
This is the original forum post, just incase chatGPT changed a step or something when formating as markdown
https://forum.opnsense.org/index.php?topic=6155.0

Hi Newbiewifi,

If I understand correctly, on your internal LAN you have a web server running a website (for example www.mysite.com).
The webserver has an fixed IP address on the LAN, and you want to access it by it's name, both from the outside and the inside network.

An alias is not going to help you, because these are only used to make your config easier to read for humans.

But here is an example that will work.
I don't know how much experience you have with configuring network things, so I will try to keep this as simple as possible and explain very detailed.

First let's make some assumptions:


    Your external IP address is 123.45.67.89
    Your LAN interface is configured as 192.168.10.1/24
    Your webserver running HTTP (port 80) and HTTPS (port 443) lives at address 192.168.10.30
    You are the owner of the domain mysite.com and the URL for your webserver is www.mysite.com
    In external DNS, you have an A record for www.mysite.com pointing to 123.45.67.89 (your external IP address)


Here is what you have to do:

Configure an aliases to make your config more readable.


    Click Firewall ==> Aliases ==> View
    Click the "Add a new alias" button
    Enter the following info:
       Type: Host(s)
       Name: Webserver
       Description: The webserver host
       Host(s): 192.168.10.30
       Description: Webserver IP address
    Click Save
    Click the "Add a new alias" button again
    Enter the following info:
       Type: Port(s)
       Name: Websrv_Ports
       Description: The webserver Ports
       Port(s): 80
       Description: HTTP port
    Click the plus sign to add another line and enter the following information
       Port(s): 443
       Description: HTTPS port
    Click Save and Apply Settings


If you are forwarding both port 80 (HTTP) and port 443 (HTTPS), you want to set the port for the web gui of your OPNsens to another port, for example port 440.
In that case you will access the web gui of OPNsense like https://yourIPaddress:440


    Click System ==> Settings ==> Administration
    Enter 440 in the TCP port field
    Click Save

The OPNsense web gui will automatically reconnect in 20 seconds, using the new port.

Add the port forwarding rule to send any incoming HTTP and HTTPS traffic to your webserver.


    Click Firewall ==> NAT ==> Port Forward
    Click the Add button to add a new Port Forward rule
    Select the following information
       Interface: WAN
       TCP/IP version: IPv4
       Protocol: TCP
       Destination: WAN Address
       Port range: From: Websrv_Ports To: Websrv_Ports
      (You can select that from the dropdown because you created the alias)
       Redirect target IP: Webserver (again, you can delect that because you created the alias)
       Redirect target ports: Websrv_Ports
       NAT reflection: Enable (Pure NAT)
       Filter rule association: Add associated filter rule
    Click Save and Apply Settings.


This will do what you want to achieve.


    The external DNS server will resolve www.mysite.com to your external IP address.
    The NAT/PortForward rule will forward this to your webserver.
    If internally www.mysite.com is also resolved to your external IP address,
    NAT Reflection will send this outgoing traffic back inside towards your webserver.


I hope this info helps.

Kind regards,
Bert
```
