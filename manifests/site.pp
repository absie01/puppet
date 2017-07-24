# Packages for nodes that lack definition, currently has all
# modules for testing purposes

node default {
  Yumrepo <| |> -> Package <| provider != 'rpm' |> #Prioritise resources of type Yumrepo (install these first)
  include ::epel
  include ::clamav
  include ::git
  include ::java
  include ::docker
  include ::rabbitmq
  include ::mongodb::server
  include ::mongodb::client
}

node 'bastion.domain.tld' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include sdes::roles::base
}

# Packages for the CI server(s)
node 'ci01.domain.tld' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include ::clamav
  include ::epel
  include ::git
  include ::jenkins::master
}

# Packages for application servers
node 'app01.domain.tld' {
  Yumrepo <| |> -> Package <| provider != 'rpm' |>
  include ::epel
  include ::git
  include ::java
  include ::clamav
}
