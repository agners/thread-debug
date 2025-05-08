# Debug scripts for Thread and Matter running on Home Assistant

This is meant to run in Advanced SSH & Web Terminal add-on with privileges.

To install or update use:
```sh
curl -fsSL https://raw.githubusercontent.com/agners/thread-debug/main/install.sh | sh
```

Commands available:
- `ot-ctl` (run OpenThread CLI commands, see the [OpenThread CLI
  Reference](https://github.com/openthread/openthread/blob/main/src/cli/README.md))
- `matter-server` (information about the local Matter Server add-on)

## Browse Matter devices

Matter uses mDNS/DNS-SD to find the Matter devices current IP address. If you
have connectivity issues with Matter devices, it is often helpful to determine
if Home Assitant can see the mDNS/DNS-SD service entry in first place.

For this you can use the Zeroconf browser (added in Home Assistant 2025.5.0) at
Settings > System > Network.

[![Open your Home Assistant instance and show your Zeroconf
Browser.](https://my.home-assistant.io/badges/config_zeroconf.svg)](https://my.home-assistant.io/redirect/config_zeroconf/)

You can find all operational Matter devicse Home Assistant sees underneath the
`_matter._tcp.local` service type. The service name represents the Matter fabric
and node. It consists of two 16 hexadecimal characters separated by a dash:

- The first 16 hexadecimal characters are the fabric identifier
- The second 16 hexadecimal characters are the node identifier

If you have a couple Matter devices on the same Matter fabric (paired to the
same controller), you should see a couple of service entries with the same
beginning (same fabric identifier).

Currently, the Home Assistant Matter Server gives for each new Matter device a
new identifier sequentially starting with 1. Most other Matter controllers give
random identifiers, so this makes Matter devices paired to the Home Assitant
Matter Controller stand out with a couple of zeros, e.g.
`0D3C0DBDDE928E1D-000000000000000D` (Matter Node ID 15).


