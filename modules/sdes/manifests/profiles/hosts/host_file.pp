class sdes::profiles::hosts::host_file {

  host{'mongodb_1':
    ip => '10.180.114.10',
  }

  host{'mongodb_2':
    ip => '10.180.114.11',
  }

  host{'mongodb_3':
    ip => '10.180.115.10',
  }

  host{'rabbit_1':
    ip => '10.180.114.20',
  }

  host{"rabbit_2":
    ip => '10.180.115.20',
  }
}