{config}: {
  sops.secrets = {
    mqtt_root = {};
    mqtt_fusebox = {};
    mqtt_zigbee = {};
    zigbee2mqtt = {
      owner = "zigbee2mqtt";
      path = "/var/lib/zigbee2mqtt/secret.yaml";
    };
  };

  networking.firewall.allowedTCPPorts = [1883]; # MQTT

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        users.root = {
          acl = ["readwrite #"];
          passwordFile = config.sops.secrets."mqtt_root".path;
        };
        users.fusebox = {
          acl = ["readwrite fusebox/#"];
          passwordFile = config.sops.secrets."mqtt_fusebox".path;
        };
        users.zigbee = {
          acl = ["readwrite zigbee/#"];
          passwordFile = config.sops.secrets."mqtt_zigbee".path;
        };
      }
    ];
  };

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      permit_join = false;
      serial.port = "/dev/ttyUSB0";
      mqtt = {
        server = "mqtt://localhost:1883";
        user = "!secret.yaml user";
        password = "!secret.yaml password";
        base_topic = "zigbee";
      };
      advanced = {
        log_level = "warn";
        # log_directory = "/var/log";
        # log_file = "zigbee2mqtt.log";
      };
    };
  };
}
